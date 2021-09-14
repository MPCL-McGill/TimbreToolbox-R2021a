function s = get_default_TEEdescs
%==========================================================================
% Default descriptors for Temporal Energy Envelope representation: 
% TEErep 

% OUTPUT: struct: Audio Descriptors 

% MEMBER OF: cTTconfig.m
%   CALLED BY: get_Descs.m
%              get_invalidDescs.m
%              check_TEEdescs.m
%       Updates the properties: 
%              Representations.TEErep.descs   
%==========================================================================
s.attackTime            = 1;
s.attackSlope           = 1;
s.decreaseSlope         = 1;
s.temporalCentroid      = 1;
s.effectiveDuration     = 1;
s.energyModulation      = 1;