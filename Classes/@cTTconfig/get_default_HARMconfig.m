function s = get_default_HARMconfig
%==========================================================================
% Default configuration for the Harmonic representation: 
% HARMrep 

% Window length and Hop size are specified in milliseconds.

% magnitudeThreshold (in dBs): Only peaks above this threshold will be
% considered.

% minPartialsDuration (in sec): Only partials above this duration will be
% considered.

% pitchRange (in Hz): Only pitches within this range will be used as pitch
% estimates from swipep.m

% inharmonicityTolerance: Max. allowable deviation of partials'
% frequencies from ideal harmonics. Only partials that deviate will be
% considered as (detuned) harmonics. 

% OUTPUT: struct: Configuration settings 

% MEMBER OF: cTTconfig.m
%   CALLED BY: get_Reps.m
%              check_HARMconfig.m
%       Updates the properties: 
%           Representations.HARMrep.config 
%==========================================================================

s.winType                   = 'blackman';
s.winLength_s               = 0.04645;      % 46.45 ms ~ 2048 samples @ 44.1 kHz
s.hopSize_s                 = 0.04645/4;    % winLength/4
s.magnitudeThreshold        = -30;          % In dBFS
s.minPartialsDuration       = 0.05;         % In seconds
s.pitchRange                = [30 5000];    % In Hz
s.inharmonicityTolerance    = 0.5;          % 0 <= Range <= 0.5 

end