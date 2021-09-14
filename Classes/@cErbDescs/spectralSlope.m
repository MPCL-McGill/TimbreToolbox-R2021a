function obj = spectralSlope(obj)
%==========================================================================
% Spectral slope. 

% OBJ: cERBrep

% CALLED BY: do_ERBrep.m
                
% MEMBER OF: cErbDescs.m 
%==========================================================================

% Mean centered frequency vector - transpose for using the dot product.
freq = (obj.CenterFrequencies - mean(obj.CenterFrequencies))';
% or use index vector
% freq = [0:length(obj.CenterFrequencies)-1] - length(obj.CenterFrequencies)/2;

% Mean of RepValues
mu_RepValues = mean(abs(obj.RepValues), 1);
% Mean centered RepValues
repVal = obj.RepValues - repmat(mu_RepValues, size(obj.RepValues,1), 1);

% Slope (dot products for numerator and denominator)
specSlope = (freq * repVal) / (freq * freq');

% Transpose for Table format
obj.SpectralSlope =  specSlope.';
end