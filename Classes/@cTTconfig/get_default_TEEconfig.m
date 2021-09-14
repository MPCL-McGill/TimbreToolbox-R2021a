function s = get_default_TEEconfig
%==========================================================================
% Default configuration for Temmporal Energy Envelope representations: 
% TEErep 
% Window length and Hop size are specified in milliseconds. 

% OUTPUT: struct: Configuration settings 

% MEMBER OF: cTTconfig.m
%   CALLED BY: get_Reps.m
%              check_TEEconfig.m
%       Updates the properties: 
%           Representations.TEErep.config 
%==========================================================================

s.noiseTHD              = -inf;     % (in dBFS) Noise threshold.
s.attackTHD             = 0;        % (in dBFS) xx dB below the max. level (=0 dBFS) of the waveform
s.decreaseSlopeTHD      = -12;      % (in dBFS) Decrease Slope will be computed up to this THD.
s.effectiveDurationTHD  = -20;      % (in dBFS) For calculating effective duration
