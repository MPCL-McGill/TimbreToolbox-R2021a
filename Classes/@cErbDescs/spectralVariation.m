function obj = spectralVariation(obj)
%==========================================================================
% Computes the spectral variation. 

% OBJ: cERBrep

% CALLED BY: do_ERBrep.m
                
% MEMBER OF: cErbDescs.m 
%==========================================================================

delayed = [zeros(size(obj.CenterFrequencies)), obj.RepValues(:, 1:end-1)];
num = sum( (obj.RepValues .* delayed), 1); 
denom = sum(obj.RepValues.^2 , 1) .* sum( delayed.^2, 1); 
specVar = 1 - ( num ./ (sqrt(denom)) );
% Replace NaNs with zeros - The first frame has zero variation.
specVar( denom == 0) = 0;
 
% Transpose for Table format
obj.SpectralVariation =  specVar.';

end