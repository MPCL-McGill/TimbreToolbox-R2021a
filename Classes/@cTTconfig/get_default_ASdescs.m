function s = get_default_ASdescs
%==========================================================================
% Default descriptors for the Audio Signal representation: 
% ASrep 

% OUTPUT: struct: Audio Descriptors 

% MEMBER OF: cTTconfig.m
%   CALLED BY: get_Descs.m
%              get_invalidDescs.m
%              check_ASdescs.m
%       Updates the properties: 
%              Representations.ASrep.descs  
%==========================================================================

s.zeroCrossingRate                      = 1;
s.frameEnergy                           = 1;
s.rmsEnergy                             = 1;     
s.autocorrelationCoefficients           = 1;
end