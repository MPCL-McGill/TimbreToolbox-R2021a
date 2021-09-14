function obj = spectralFlux(obj)
%==========================================================================
% Computes the spectral flux. 

% OBJ: cHARMrep

% CALLED BY: do_HARMrep.m
                
% MEMBER OF: cHarmDescs.m 
%==========================================================================

% Difference between spectral frames.
% (Concatenate with first frame to get back the original size of the
% matrix. The first difference will be zero.)
Delta = diff([obj.PartialsAmplitudes(:,1), obj.PartialsAmplitudes], 1, 2);

specFlux = sqrt(sum(Delta.*Delta))/size(obj.PartialsAmplitudes, 1);
 
% Transpose for Table format
obj.SpectralFlux =  specFlux.';

end