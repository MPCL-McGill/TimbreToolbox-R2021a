function s = get_default_ASconfig
%==========================================================================
% Default configuration for both Audio Signal representation: 
% ASrep 
% Window length and Hop size are specified in milliseconds. 

% OUTPUT: struct: Configuration settings 

% MEMBER OF: cTTconfig.m
%   CALLED BY: get_Reps.m
%              check_ASconfig.m
%       Updates the properties: 
%           Representations.ASrep.config 
%==========================================================================

s.winLength_s   = 0.04645;    % 46.45 ms ~ 2048 samples @ 44.1 kHz
s.hopSize_s     = 0.04645/2;  % winLength/2