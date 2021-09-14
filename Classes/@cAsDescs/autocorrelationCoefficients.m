function obj = autocorrelationCoefficients(obj)
%==========================================================================
% Retrieves the Autocorrelation Coefficients computed from the @cASrep.

% OBJ: cASrep

% CALLED BY: do_ASrep.m
                
% MEMBER OF: cAsDescs.m 
%==========================================================================

obj.ZeroCrossingRate =  obj.Zcr;
obj.AutoCorrCoef_01     =  obj.Acc(:, 1);
obj.AutoCorrCoef_02     =  obj.Acc(:, 2);
obj.AutoCorrCoef_03     =  obj.Acc(:, 3);
obj.AutoCorrCoef_04     =  obj.Acc(:, 4);
obj.AutoCorrCoef_05     =  obj.Acc(:, 5);
obj.AutoCorrCoef_06     =  obj.Acc(:, 6);
obj.AutoCorrCoef_07     =  obj.Acc(:, 7);
obj.AutoCorrCoef_08     =  obj.Acc(:, 8);
obj.AutoCorrCoef_09     =  obj.Acc(:, 9);
obj.AutoCorrCoef_10     =  obj.Acc(:, 10);
obj.AutoCorrCoef_11     =  obj.Acc(:, 11);
obj.AutoCorrCoef_12     =  obj.Acc(:, 12);
obj.AutoCorrCoef_13     =  obj.Acc(:, 13);
obj.AutoCorrCoef_14     =  obj.Acc(:, 14);
obj.AutoCorrCoef_15     =  obj.Acc(:, 15);
obj.AutoCorrCoef_16     =  obj.Acc(:, 16);
obj.AutoCorrCoef_17     =  obj.Acc(:, 17);
obj.AutoCorrCoef_18     =  obj.Acc(:, 18);
obj.AutoCorrCoef_19     =  obj.Acc(:, 19);
obj.AutoCorrCoef_20     =  obj.Acc(:, 20);

end