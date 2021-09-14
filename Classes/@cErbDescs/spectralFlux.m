function obj = spectralFlux(obj)
%==========================================================================
% Computes the spectral flux. 

% OBJ: cERBrep

% CALLED BY: do_ERBrep.m
                
% MEMBER OF: cErbDescs.m 
%==========================================================================

% Difference between spectral frames.
% (Concatenate with first frame to get back the original size of the
% matrix. The first difference will be zero.)
Delta = diff([obj.RepValues(:,1), obj.RepValues], 1, 2);

specFlux = sqrt(sum(Delta.^2))/size(obj.RepValues, 1);
 
% Transpose for Table format
obj.SpectralFlux =  specFlux.';

end