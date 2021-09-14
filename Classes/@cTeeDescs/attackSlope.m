function obj = attackSlope(obj)
%==========================================================================
% Computes the attack slope. 

% OBJ: cTeerep

% CALLED BY: do_TEErep.m
                
% MEMBER OF: cTeeDescs.m 
%==========================================================================
attackSlopeTHD  = -48;      % (in dBFS) Local Attack Slopes will be computed above this THD. 
incrStep        = 6;        % (in dB) Increament step for calculating local Attack Slopes.

sat     = find(obj.RectifiedWav > obj.NoiseTHD, 1);     % Start of attack (in samples)
eat     = find(obj.RectifiedWav >= obj.AttackTHD, 1);   % End of attack (in samples)

satv            = obj.RectifiedWav(sat);        % sat value (dB)
eatv            = obj.RectifiedWav(eat);        % Should be approx. the same as attackTHD
thds            = attackSlopeTHD:incrStep:eatv; % THDs for calculating local Attack Time Slopes.
thds            = [satv thds];                  % Should include satv
thds(thds<satv) = [];                           % Remove thds < satv
thdSec          = zeros(size(thds));            % Time it takes to reach/cross the thds.

for p = 1:length(thds)
	thdSec(p)   = (find(obj.RectifiedWav(sat:eat) >= thds(p), 1)) / obj.Fs;
end
[thdSec, idx]   = unique(thdSec);               % Get unique thdSec sorted in time (for rare cases)
thds            = thds(idx);                    % And respective thds
attSlope        = diff(thds) ./ diff(thdSec);   % Local attack slopes
attSlope        = mean(attSlope);               % Attack slope as the mean of local slopes:

obj.AttackSlope =  attSlope;
end