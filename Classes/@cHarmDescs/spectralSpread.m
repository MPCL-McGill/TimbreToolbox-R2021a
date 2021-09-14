function obj = spectralSpread(obj)
%==========================================================================
% Computes the spectral spread. 

% OBJ: cHARMrep

% CALLED BY: do_HARMrep.m
                
% MEMBER OF: cHarmDescs.m 
%==========================================================================

if  ~isempty(obj.SpectralCentroid)
    % Don't compute again spectral centroid. 
    specCent = obj.SpectralCentroid.';  % Transpose back to original size.
else % Compute spectral centroid.
specCent = sum (obj.PartialsFrequencies .* obj.PartialsAmplitudes)...
    ./ sum(obj.PartialsAmplitudes, 1);
    % Replace NaNs with zeros (silent frames).
    specCent( sum(obj.PartialsAmplitudes,1) == 0) = 0;
end

% Normalize the amplitude spectrum
namp = obj.PartialsAmplitudes ./ ...
    repmat ( sum(obj.PartialsAmplitudes,1), size(obj.PartialsAmplitudes,1), 1);
% Mean centered frequency
mf = (obj.PartialsFrequencies - repmat(specCent, size(obj.PartialsAmplitudes,1), 1));
% Spectral Spread
specSpread = sum(mf.*mf .* namp) .^ (1/2);
% Replace NaNs with zeros (silent frames).
specSpread( sum(obj.PartialsAmplitudes,1) == 0) = 0;

% Transpose for Table format
obj.SpectralSpread = specSpread.';

end