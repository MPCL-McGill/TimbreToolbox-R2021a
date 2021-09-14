function obj = spectralSlope(obj)
%==========================================================================
% Spectral slope. 

% OBJ: cSTFTrep

% CALLED BY: do_PowSTFTrep.m
%            do_Mag_STFTrep.m
                
% MEMBER OF: cSpecDescs.m 
%==========================================================================

% Mean centered frequency vector
freq = (obj.PartialsFrequencies - mean(obj.PartialsFrequencies));

% Mean of PartialsAmplitudes
mu_RepValues = mean(abs(obj.PartialsAmplitudes), 1);
% Mean centered PartialsAmplitudes
repVal = obj.PartialsAmplitudes - repmat(mu_RepValues, size(obj.PartialsAmplitudes,1), 1);

% Slope 
denom = sum(freq .* freq);
specSlope = sum(freq .* repVal) ./ denom;
% Avoid NaNs:
specSlope(denom==0) = 0;

% Transpose for Table format
obj.SpectralSlope =  specSlope.';
end