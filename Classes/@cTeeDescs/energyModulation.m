function obj = energyModulation(obj)
%==========================================================================
% Computes the energy modulation. 

% OBJ: cTeerep

% CALLED BY: do_TEErep.m

% MEMBER OF: cTeeDescs.m 
%==========================================================================

minf                = 1;                            % (in Hz) Minimum modulation frequency 
maxf                = 20;                           % (in Hz) Maximum modulation frequency 
minSustainDuration  = 0.1;                          % (in sec) 
localMaximaTHD      = obj.EffectiveDurationTHD;     % (in dBFS) The first local max. must have a value above this threshold
 
[~, sat] = findpeaks(obj.PowerEnvelope, 'MinPeakHeight', db2mag(localMaximaTHD)); % Start of "attack"
if ~isempty(sat)
    sat = sat(1); % Keep only the first local max. 
else
    sat = max(obj.RectifiedWav);
end
% [~, sdec]     = max(obj.RectifiedWav);                                          % Start of decrease (value(in dB) and sample#).
edec            = find(obj.RectifiedWav > obj.DecreaseSlopeTHD, 1, 'last');       % End of decrease (sustain part).


% if ((edec - sdec)/obj.Fs) > minSustainDuration       % If there is a sustained part
if ((edec - sat)/obj.Fs) > minSustainDuration          % If there is a sustained part
    % sustainEnv = obj.PowerEnvelope(sdec:edec);       % Get the sustained part (its length may be modified in the following lines).
    sustainEnv = obj.PowerEnvelope(sat:edec);          % Get the sustained part (its length may be modified in the following lines).
     
%     % ============================== FIT ==================================
%     % polyfit using LIN values
%     sustainEnvLin  = sustainEnv;
%     xVals       = (1:length(sustainEnvLin))';
%     p           = polyfit(xVals, sustainEnvLin, 1);
%     linFit      = polyval(p, 1:length(sustainEnvLin));
%     linFit      = linFit(:);
%     linFit(linFit<0) = [];                      % Check that linFit > 0 
%     sustainEnvLin  = sustainEnvLin(1:length(linFit)); % Monotonic decrease
%     envResid    = sustainEnvLin - linFit;
%     SSresid     = sum(envResid.^2);
%     SStotal     = (length(sustainEnvLin)-1) * var(sustainEnvLin);
%     Rlin        = 1 - SSresid/SStotal;
%     % polyfit using LOG values
%     sustainEnvLog  = sustainEnv;
%     xVals       = (1:length(sustainEnvLog))';
%     p           = polyfit(xVals, log(sustainEnvLog), 1);
%     logFit      = exp(polyval(p, 1:length(sustainEnvLog)));
%     logFit      = logFit(:);
%     logFit(logFit<0) = [];                      % Check that logFit > 0 
%     sustainEnvLog  = sustainEnvLog(1:length(logFit)); % Monotonic decrease
%     envResid    = sustainEnvLog - logFit;
%     SSresid     = sum(envResid.^2);
%     SStotal     = (length(sustainEnvLog)-1) * var(sustainEnvLog);
%     Rlog        = 1 - SSresid/SStotal;
%     % Get the best of the two Fits according to Rsq
%     % First check for NaN
%     if ~isnan(Rlin) &&  ~isnan(Rlog) % Compare the R values
%         if Rlin >= Rlog
%             sig = sustainEnvLin - linFit;
%         else
%             sig = sustainEnvLog - logFit;
%         end
%     elseif isnan(Rlog) && ~isnan(Rlin) % Remove the linear fit.
%         sig = sustainEnvLin - linFit; 
%     else
%         sig = sustainEnv; % safest to ignore the case: isnan(Rlin) && ~isnan(Rlog)
%     end
    
    % ============================== FFT ==================================  
    sig = sustainEnv; 
    % Remove DC offset
    sig = sig - mean(sig);

    L           = length(sig);
    win         = hann(L, 'periodic');
    if mod(L, 2) % If Odd, use an even FFT length 
       L = L+1; 
    end
    Y           = fft(sig.*win/sum(win), L);
    P           = abs(Y/L);
    P           = P(1:L/2+1);
    P(2:end-1)  = 2*P(2:end-1);
    F           = (obj.Fs*(0:(L/2))/L)';

    % =========================== AM - FM =================================
    idx         = find(F <= maxf & F >= minf);
    [AM, AMidx] = max(P(idx));  % Find max amplitude (AM) and 
    AMidx       = idx(AMidx);   % at which position (AMidx = frequency index)
    FM          = F(AMidx);     % Frequency at which max amplitude occurs
    
else % The sound is not sustained
    AM = 0; 
    FM = 0;
end

obj.FrequencyOfEnergyModulation = FM;
obj.AmplitudeOfEnergyModulation = AM;
end