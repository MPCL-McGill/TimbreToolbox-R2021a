function obj = spectralFlatness(obj)
%==========================================================================
% Spectral flatness measure (sfm). 

% OBJ: cERBrep

% CALLED BY: do_ERBrep.m
                
% MEMBER OF: cErbDescs.m 
%==========================================================================

sfm = exp( mean(log(obj.RepValues+eps), 1) ) ./ (mean(obj.RepValues, 1));
% Replace NaNs with zeros (silent frames)
sfm(sum(obj.RepValues, 1) == 0) = 0;

% Transpose for Table format
obj.SpectralFlatness =  sfm.';
end