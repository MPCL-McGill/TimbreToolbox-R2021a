function obj = spectralDecrease(obj)
%==========================================================================
% Spectral decrease. 

% OBJ: cERBrep

% CALLED BY: do_ERBrep.m
                
% MEMBER OF: cErbDescs.m 
%==========================================================================

numerator = obj.RepValues(2:end, :) - ...
    repmat(obj.RepValues(1,:), size(obj.RepValues,1) - 1, 1);
% This is the 1/(k-1) factor in Peeters et al. JASA 2011
denominator = 1 ./ (1:length(obj.CenterFrequencies)-1); 
% Compute the sum as a dot product:
specDecr = (denominator * numerator) ./ sum(obj.RepValues(2:end,:), 1);
% Replace NaNs with zeros (silent frames).
specDecr( sum(obj.RepValues(2:end,:), 1) == 0) = 0;

% Transpose for Table format
obj.SpectralDecrease =  specDecr.';
end