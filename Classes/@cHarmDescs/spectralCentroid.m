function obj = spectralCentroid(obj)
%==========================================================================
% Computes the spectral centroid. 

% OBJ: cHARMrep

% CALLED BY: do_HARMrep.m
                
% MEMBER OF: cHarmDescs.m 
%==========================================================================

specCent = sum (obj.PartialsFrequencies .* obj.PartialsAmplitudes)...
    ./ sum(obj.PartialsAmplitudes, 1);
% Replace NaNs with zeros (silent frames).
specCent( sum(obj.PartialsAmplitudes,1) == 0) = 0;

% Transpose for Table format
obj.SpectralCentroid =  specCent.';

end