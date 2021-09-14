function s = get_default_ERBconfig
%==========================================================================
% Default configuration for the ERB representation: 
% ERBrep  

% OUTPUT: struct: Configuration settings 

% MEMBER OF: cTTconfig.m
%   CALLED BY: get_Reps.m
%              check_ERBconfig.m
%       Updates the properties: 
%           Representations.ERBrep.config 
%==========================================================================

s.winLength_s   = 0.02;     % in ms
s.hopSize_s     = 0.01;     % in ms
s.fLow          = 50;       % (in Hz) Lowest center frequency of the gammatone filterbank
s.nChannels     = 64;       % number of ERB filters
