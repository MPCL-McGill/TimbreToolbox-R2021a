function obj = spectralRollOff(obj)
%==========================================================================
% Computes the spectral roll-off. 

% OBJ: cERBrep

% CALLED BY: do_ERBrep.m
                
% MEMBER OF: cErbDescs.m 
%==========================================================================

thd = 0.95; % Threshold
% thd = 0.85; 

cumulativeSum = cumsum(obj.RepValues);
Sum = thd * sum(obj.RepValues, 1);
cumuOverSumBins = cumulativeSum >= repmat( Sum, size(obj.RepValues,1), 1 );
[idx, ~] = find(cumsum(cumuOverSumBins) == 1);

specRollOff = obj.CenterFrequencies(idx);
% No need to transpose the values for Table
obj.SpectralRollOff = specRollOff;

end