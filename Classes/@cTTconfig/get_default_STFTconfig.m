function s = get_default_STFTconfig
%==========================================================================
% Default configuration for both STFT representations: 
% PowSTFTrep and MagSTFTrep
% Window length and Hop size are specified in milliseconds. 

% OUTPUT: struct: Configuration settings 

% MEMBER OF: cTTconfig.m
%   CALLED BY: get_Reps.m
%              check_STFTconfig.m
%       Updates the properties: 
%           Representations.PowSTFTrep.config 
%           Representations.MagSTFTrep.config 
%==========================================================================

s.winType       = 'hann';
s.winLength_s   = 0.04645;  % 46.45 ms ~ 2048 samples @ 44.1 kHz
s.hopSize_s     = 0.04645/4;  % winLength/4
