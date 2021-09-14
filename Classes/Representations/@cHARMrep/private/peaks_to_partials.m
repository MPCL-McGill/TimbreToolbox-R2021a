function [P, Zi, Zf, trameCouranteZ, tag] = peaks_to_partials(F, Zi, Zf, trameCouranteZ, tag)
%==========================================================================
% Connects peaks to partials using Linear Prediction.

% Zi: 1st column: partial's ID (if = 0 then row available) 
%      2nd column: Zombie frame counter
%      3rd column: number of frames in which the partial has been alive.
% Zf: partials' frequencies 
%     (number of columns corresponds to the number of past frames that 
%     will be taken into account for the LPC analysis) 
% (Each line of Zf and Zi corresponds to the same partial.)

% trameCouranteZ:   current frame of Zf
% tag :             1+number ID of the last partial

% CALLED BY: cHARMrep.m (Constructor)

% Disclaimer: This is a modification of the function peaks2partialsLp.m 
% found in: The DESAM Toolbox Package version 1.0
%==========================================================================

% -------------------- Initialization -------------------------------------
deltaF      = 40;                       % maximum allowable frequency deviation
dureeActif  = 4;                        % number of Zombie frames
n           = 32;                       % number of frames used in Linear Prediction (LP)
nbFrames    = size(F, 2);
nbPeaks     = size(F, 1);
P           = zeros(nbPeaks, nbFrames); % Partials' indexes

if nargin < 5
   Zi = zeros(nbPeaks, 3); 
   Zf = zeros(nbPeaks, n); 
   trameCouranteZ = 1; 
   tag = 1; 
end

for k = 1:nbFrames 
    tabPeaks = ones(1, nbPeaks);    % Peaks without continuation
    for l = 1:size(Zf, 1) 
        if (Zi(l, 1) ~= 0)          % If there is a cadidate peak or if the partial is not DEAD.
            if (Zi(l, 3) < 4)       % If not enough frames (<4) do MAQ algorithm.
                est_x = Zf(l, mod(trameCouranteZ-2, n) +1);
            else 
% --------- Check whether to do LP or not ---------------------------------
                x = zeros(1, Zi(l, 3)); 
                for p = 1:size(x, 2) 
                    x(1, p) = Zf(l, mod(trameCouranteZ-2 - Zi(l, 3)+p, n) +1);
                    if (p == 1)         % The partial is stable (don't do LP)
                        verifId = x(1,1);
                    end
                    if (verifId ~= x(1,p))
                         verifId = -1;  % Do LP
                    end
                end   
                if ~all(isfinite(x)) % This may occur because of x(1, p) = Zf(l, mod....)
                    x(isnan(x)) = 0;
                end
% ------------- Do Prediction ---------------------------------------------
                if (verifId == -1) % Do LP
                    est_x = 0;
                    if size(x,2) < 19
                         a = arburg(x, floor( (size(x,2)-1) /2) );
                    else % set limit to 8 LP coeffs
                       a = arburg(x, 8);
                    end
                    for p = 2:size(a,2) 
                        est_x = est_x - a(p)*x(1, size(x, 2) + 1 - p);
                    end
                else % Don't use an estimate (don't do LP)
                    est_x = x(1, 1);
                end
            end % Prediction 
            
% --------- Search for the peak closest to the est_x ----------------------
            Zf(l, trameCouranteZ) = est_x;
            indPeak = 0;
            deltaF2 = deltaF;
            for p = 1:nbPeaks
                % If the peak is available and if the estimation satisfies deltaF
                if ( (tabPeaks(p) == 1) && (abs(F(p,k)-est_x) < deltaF2) )
                    indPeak = p;
                    % New deltaF in order to get the closest match
                    deltaF2 = abs(F(p,k) - est_x);
                end
            end         
            if (indPeak ~= 0) % If condition is satisfied
                tabPeaks(indPeak) = 0;      % Peak is linked to a partial (becomes unavailable)
                Zi(l, 2) = dureeActif;      % Reset Zombie duration
                Zf(l, trameCouranteZ) = F(indPeak, k);
                P(indPeak, k) = Zi(l, 1);   % Link partial to the peak index Zi(l, 1)
            else %  deltaF criterion was NOT satisfied
                Zi(l, 2) = Zi(l, 2) - 1;    % Decrease Zombie state
                if (Zi(l, 2) == 0)          % Partial is DEAD 
                    Zi(l, 1) = 0;           % Unlink Partial
                end
            end
        end % Linking partials to peaks. 
        
        if (Zi(l, 3) < n-1)             % Update the number of frames for which the partial is alive.
            Zi(l, 3) = Zi(l, 3) + 1;    % This used in LP calculation. 
        end
    end
    
% -- Create potential partials for the unlinked peaks ---------------------
    for p = 1:nbPeaks
        if (tabPeaks(p) == 1 && F(p,k) ~= 0) % If the peak is available
            indLibre = 0; 
            for h = 1:size(Zi, 1)   % search for a free line in Zi,1 to insert the partial
                if (Zi(h, 1) == 0)  % Row is availaible 
                   indLibre = h; 
                   break;           % Get the first h and exit the for-loop.
                end
            end 
            if (indLibre == 0)                  % If not free, then add a line 
               Zf                   = [Zf; zeros(1, n)];    
               Zf(size(Zf, 1), trameCouranteZ) = F(p, k);   % Assign the the frequency of that peak
               Zi                   = [Zi; zeros(1,3)];     % Add a line
               Zi(size(Zi,1), 1)    = tag;                  % Partial's ID
               Zi(size(Zi,1), 2)    = dureeActif;           % Zombie frames 
               Zi(size(Zi,1), 3)    = 1;                    % Start observing            
            else % The line is available (use it for the new partial)
                % Initialization
                Zf(indLibre, :) = zeros(1, n); 
                Zf(indLibre, trameCouranteZ) = F(p, k); 
                Zi(indLibre, :) = zeros(1, 3); 
                Zi(indLibre, 1) = tag;
                Zi(indLibre, 2 ) = dureeActif;
                Zi(indLibre, 3) = 1;
            end

            P(p, k) = tag; % Partial's index (ID).
            tag = tag+1; 
        end % If peak is available (to create new partials).  
    end % No more peaks left to check.
    
    trameCouranteZ = mod(trameCouranteZ, size(Zf, 2)) + 1;  
end % no more frames left

end 