function obj = spectralVariation(obj)
%==========================================================================
% Computes the spectral variation. 

% OBJ: cSTFTrep

% CALLED BY: do_PowSTFTrep.m
%            do_Mag_STFTrep.m
                
% MEMBER OF: cSpecDescs.m 
%==========================================================================

delayed = [zeros(size(obj.FrequencyBins)), obj.RepValues(:, 1:end-1)];
num = sum( (obj.RepValues .* delayed), 1); 
denom = sum(obj.RepValues.^2 , 1) .* sum( delayed.^2, 1); 
specVar = 1 - ( num ./ (sqrt(denom)) );
% Replace NaNs with zeros - The first frame has zero variation.
specVar( denom == 0) = 0;
 
% Transpose for Table format
obj.SpectralVariation =  specVar.';

end