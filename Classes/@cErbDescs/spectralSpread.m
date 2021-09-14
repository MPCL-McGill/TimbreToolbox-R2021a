function obj = spectralSpread(obj)
%==========================================================================
% Computes the spectral spread. 

% OBJ: cERBrep

% CALLED BY: do_ERBrep.m
                
% MEMBER OF: cErbDescs.m 
%==========================================================================

if  ~isempty(obj.SpectralCentroid)
    % Don't compute again spectral centroid. 
    specCent = obj.SpectralCentroid.';  % Transpose back to original size.
else % Compute spectral centroid.
    % Dot product (transpose CenterFrequencies)
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

% Transpose for Table format
obj.SpectralSpread = specSpread.';

end