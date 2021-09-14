function obj = spectralSkewness(obj)
%==========================================================================
% Computes the spectral skewness. 

% OBJ: cERBrep

% CALLED BY: do_ERBrep.m
                
% MEMBER OF: cErbDescs.m 
%==========================================================================

% % Check if Centroid was previously calculated.
if  ~isempty(obj.SpectralCentroid)
    % Don't compute again spectral centroid. 
    specCent = obj.SpectralCentroid.'; % Transpose back to original size.
else % Compute spectral centroid.
    specCent = (obj.CenterFrequencies')*obj.RepValues ./ sum(obj.RepValues,1);
    % Replace NaNs with zeros (silent frames).
    specCent( sum(obj.RepValues,1) == 0) = 0;
end

% Normalize the amplitude spectrum
namp = obj.RepValues ./ ...
    repmat ( sum(obj.RepValues,1), size(obj.RepValues,1), 1);
% Mean centered frequency
mf = (obj.CenterFrequencies - repmat(specCent, size(obj.RepValues,1), 1));
% Spectral Spread
specSpread = sum(mf.*mf .* namp) .^ (1/2);
% Replace NaNs with zeros (silent frames).
specSpread( sum(obj.RepValues,1) == 0) = 0;
% Skewness
specSkewness = sum(mf.*mf.*mf .* namp) ./ (specSpread.*specSpread.*specSpread);

% Replace NaNs with zeros.
specSkewness( specSpread == 0) = 0;

% Transpose for Table format
obj.SpectralSkewness = specSkewness.';

end