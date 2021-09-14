function obj = spectralRollOff(obj)
%==========================================================================
% Computes the spectral roll-off. 

% OBJ: cHARMrep

% CALLED BY: do_HARMrep.m
                
% MEMBER OF: cHarmDescs.m 
%==========================================================================

thd = 0.95; % Threshold
% thd = 0.85; 

cumulativeSum = cumsum(obj.PartialsAmplitudes);
Sum = thd * sum(obj.PartialsAmplitudes, 1);
cumuOverSumBins = cumulativeSum >= repmat( Sum, size(obj.PartialsAmplitudes,1), 1 );
[idx, ~] = find(cumsum(cumuOverSumBins) == 1);

specRollOff = obj.PartialsFrequencies(idx);
% No need to transpose the values for Table
obj.SpectralRollOff = specRollOff;

end