function s = get_default_HARMdescs
%==========================================================================
% Default descriptors for the Harmonic representation: 
% HARMrep 

% OUTPUT: struct: Audio Descriptors 

% MEMBER OF: cTTconfig.m
%   CALLED BY: get_Descs.m
%              get_invalidDescs.m
%              check_HARMdescs.m
%       Updates the properties: 
%              Representations.HARMrep.descs  
%==========================================================================

s.spectralCentroid          = 1;
s.spectralSpread            = 1;
s.spectralSkewness          = 1;
s.spectralKurtosis          = 1;
s.spectralFlatness          = 1;
s.spectralCrest             = 1; 
s.spectralSlope             = 1; 
s.spectralDecrease          = 1;
s.spectralRollOff           = 1;
s.spectralVariation         = 1;
s.spectralFlux              = 1;
s.harmonicSpectralDeviation = 1;
s.tristimulusValues         = 1;
s.harmonicOddToEvenRatio    = 1;
s.inharmonicity             = 1;
s.harmonicEnergy            = 1;

end