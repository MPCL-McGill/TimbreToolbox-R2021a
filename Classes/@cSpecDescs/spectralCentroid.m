function obj = spectralCentroid(obj)
%==========================================================================
% Computes the spectral centroid. 

% OBJ: cSTFTrep

% CALLED BY: do_PowSTFTrep.m
%            do_Mag_STFTrep.m
                
% MEMBER OF: cSpecDescs.m 
%==========================================================================

% Dot product (transpose FrequencyBins)
specCent = (obj.FrequencyBins')*obj.RepValues ./ sum(obj.RepValues,1);
% Replace NaNs with zeros (silent frames).
specCent( sum(obj.RepValues,1) == 0) = 0;

% Transpose for Table format
obj.SpectralCentroid =  specCent.';

end