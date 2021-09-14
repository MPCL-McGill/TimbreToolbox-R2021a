function obj = spectralDecrease(obj)
%==========================================================================
% Spectral decrease. 

% OBJ: cHARMrep

% CALLED BY: do_HARMrep.m
                
% MEMBER OF: cHarmDescs.m 
%==========================================================================

numerator = obj.PartialsAmplitudes(2:end, :) - ...
    repmat(obj.PartialsAmplitudes(1,:), size(obj.PartialsAmplitudes,1) - 1, 1);

% This is the 1/(k-1) factor in Peeters et al. JASA 2011
denominator = 1 ./ (1:size(obj.PartialsFrequencies,1)-1); 
% Compute the sum as a dot product:
specDecr = (denominator * numerator) ./ sum(obj.PartialsAmplitudes(2:end,:), 1);
% Replace NaNs with zeros (silent frames).
specDecr( sum(obj.PartialsAmplitudes(2:end,:), 1) == 0) = 0;

% Transpose for Table format
obj.SpectralDecrease =  specDecr.';
end