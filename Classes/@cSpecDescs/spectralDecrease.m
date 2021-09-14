function obj = spectralDecrease(obj)
%==========================================================================
% Spectral decrease. 

% OBJ: cSTFTrep

% CALLED BY: do_PowSTFTrep.m
%            do_Mag_STFTrep.m
                
% MEMBER OF: cSpecDescs.m 
%==========================================================================

numerator = obj.RepValues(2:end, :) - ...
    repmat(obj.RepValues(1,:), size(obj.RepValues,1) - 1, 1);
% This is the 1/(k-1) factor in Peeters et al. JASA 2011
denominator = 1 ./ (1:length(obj.FrequencyBins)-1); 
% Compute the sum as a dot product:
specDecr = (denominator * numerator) ./ sum(obj.RepValues(2:end,:), 1);
% Replace NaNs with zeros (silent frames).
specDecr( sum(obj.RepValues(2:end,:), 1) == 0) = 0;

% Transpose for Table format
obj.SpectralDecrease =  specDecr.';
end