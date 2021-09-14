function obj = attackTime(obj)
%==========================================================================
% Computes the attack time. 

% OBJ: cTeerep

% CALLED BY: do_TEErep.m
                
% MEMBER OF: cTeeDescs.m 
%==========================================================================

sat     = find(obj.RectifiedWav > obj.NoiseTHD, 1);     % Start of attack (in samples)
eat     = find(obj.RectifiedWav >= obj.AttackTHD, 1);   % End of attack (in samples)
att     = (eat - sat) / obj.Fs;                         % Attack Time (sec)

obj.AttackTime      =  att;
obj.LogAttackTime   =  log10(att);

end