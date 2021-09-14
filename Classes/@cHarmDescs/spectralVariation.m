function obj = spectralVariation(obj)
%==========================================================================
% Computes the spectral variation. 

% OBJ: cHARMrep

% CALLED BY: do_HARMrep.m
                
% MEMBER OF: cHarmDescs.m 
%==========================================================================

delayed = [zeros(size(obj.PartialsFrequencies,1),1), obj.PartialsAmplitudes(:, 1:end-1)];
num = sum( (obj.PartialsAmplitudes .* delayed), 1); 
denom = sum(obj.PartialsAmplitudes.^2 , 1) .* sum( delayed.^2, 1); 
specVar = 1 - ( num ./ (sqrt(denom)) );
% Replace NaNs with zeros - The first frame has zero variation.
specVar( denom == 0) = 0;
 
% Transpose for Table format
obj.SpectralVariation =  specVar.';

end