function obj = spectralRollOff(obj)
%==========================================================================
% Computes the spectral roll-off. 

% OBJ: cSTFTrep

% CALLED BY: do_PowSTFTrep.m
%            do_Mag_STFTrep.m
                
% MEMBER OF: cSpecDescs.m 
%==========================================================================

thd = 0.95; % Threshold
% thd = 0.85; 

cumulativeSum = cumsum(obj.RepValues);
Sum = thd * sum(obj.RepValues, 1);
cumuOverSumBins = cumulativeSum >= repmat( Sum, size(obj.RepValues,1), 1 );
[idx, ~] = find(cumsum(cumuOverSumBins) == 1);

specRollOff = obj.FrequencyBins(idx);
% No need to transpose the values for Table
obj.SpectralRollOff = specRollOff;

end