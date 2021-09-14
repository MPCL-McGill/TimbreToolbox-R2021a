function obj = spectralFlatness(obj)
%==========================================================================
% Spectral flatness measure (sfm). 

% OBJ: cHARMrep

% CALLED BY: do_HARMrep.m
                
% MEMBER OF: cHarmDescs.m 
%==========================================================================

sfm = exp( mean(log(obj.PartialsAmplitudes+eps), 1) ) ./ (mean(obj.PartialsAmplitudes, 1));
% Replace NaNs with zeros (silent frames)
sfm(sum(obj.PartialsAmplitudes, 1) == 0) = 0;

% Transpose for Table format
obj.SpectralFlatness =  sfm.';
end