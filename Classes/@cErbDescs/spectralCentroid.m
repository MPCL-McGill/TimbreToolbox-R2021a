function obj = spectralCentroid(obj)
%==========================================================================
% Computes the spectral centroid. 

% OBJ: cERBrep

% CALLED BY: do_ERBrep.m
                
% MEMBER OF: cErbDescs.m 
%==========================================================================

% Dot product (transpose CenterFrequencies)
specCent = (obj.CenterFrequencies')*obj.RepValues ./ sum(obj.RepValues,1);
% Replace NaNs with zeros (silent frames).
specCent( sum(obj.RepValues,1) == 0) = 0;

% Transpose for Table format
obj.SpectralCentroid =  specCent.';

end