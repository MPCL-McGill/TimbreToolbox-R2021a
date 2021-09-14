function obj = harmonicOddToEvenRatio(obj)
%==========================================================================
% Computes the odd to even ratio (oer). 

% OBJ: cHARMrep

% CALLED BY: do_HARMrep.m
                
% MEMBER OF: cHarmDescs.m 
%==========================================================================

oer = sum(obj.HarmonicAmps(1:2:end, :).^2, 1) ./ ...
    (sum(obj.HarmonicAmps(2:2:end, :).^2, 1) + eps);

 
% Transpose for Table format
obj.HarmonicOddToEvenRatio =  oer.';

end