function obj = spectralSlope(obj)
%==========================================================================
% Spectral slope. 

% OBJ: cSTFTrep

% CALLED BY: do_PowSTFTrep.m
%            do_Mag_STFTrep.m
                
% MEMBER OF: cSpecDescs.m 
%==========================================================================

% Mean centered frequency vector - transpose for using the dot product.
freq = (obj.FrequencyBins - mean(obj.FrequencyBins))';
% or use index vector
% freq = [0:length(obj.FrequencyBins)-1] - length(obj.FrequencyBins)/2;

% Mean of RepValues
mu_RepValues = mean(abs(obj.RepValues), 1);
% Mean centered RepValues
repVal = obj.RepValues - repmat(mu_RepValues, size(obj.RepValues,1), 1);

% Slope (dot products for numerator and denominator)
specSlope = (freq * repVal) / (freq * freq');

% Transpose for Table format
obj.SpectralSlope =  specSlope.';
end