function obj = effectiveDuration(obj)
%==========================================================================
% Computes the effective duration. 

% OBJ: cTeerep

% CALLED BY: do_TEErep.m
                
% MEMBER OF: cTeeDescs.m 
%==========================================================================

sed     = find(obj.PowerEnvelope > 10.^(obj.EffectiveDurationTHD/10), 1);          % Start of effective duration
eed     = find(obj.PowerEnvelope > 10.^(obj.EffectiveDurationTHD/10), 1, 'last');  % End of effective duration
ed      = length(obj.PowerEnvelope(sed:eed)) / obj.Fs;                            % Effective duration in seconds
    
obj.EffectiveDuration =  ed;
end