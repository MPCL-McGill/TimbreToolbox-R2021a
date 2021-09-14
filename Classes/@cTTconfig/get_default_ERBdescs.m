function s = get_default_ERBdescs
%==========================================================================
% Default descriptors for the ERBrep. 

% OUTPUT: struct: Audio Descriptors 

% MEMBER OF: cTTconfig.m
%   CALLED BY: get_Descs.m
%              get_invalidDescs.m
%              check_ERBdescs.m
%       Updates the properties: 
%              Representations.ERBrep.descs  
%==========================================================================

s.spectralCentroid      = 1;
s.spectralSpread        = 1;
s.spectralSkewness      = 1;
s.spectralKurtosis      = 1;
s.spectralFlatness      = 1;
s.spectralCrest         = 1; 
s.spectralSlope         = 1; 
s.spectralDecrease      = 1;
s.spectralRollOff       = 1;
s.spectralVariation     = 1;
s.spectralFlux          = 1;