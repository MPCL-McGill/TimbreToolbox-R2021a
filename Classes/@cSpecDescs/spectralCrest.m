function obj = spectralCrest(obj)
%==========================================================================
% Spectral crest measure (scm). 

% OBJ: cSTFTrep

% CALLED BY: do_PowSTFTrep.m
%            do_Mag_STFTrep.m
                
% MEMBER OF: cSpecDescs.m 
%==========================================================================

% Peeters formulation:
% scm = max(obj.RepValues,[],1) ./ (mean(obj.RepValues, 1));

% Or use the sum instead: restrict values in the range: 2/nBins to 1:
scm = max(obj.RepValues,[],1) ./ (sum(obj.RepValues, 1));

% Replace NaNs with zeros (silent frames).
scm( sum(obj.RepValues,1) == 0) = 0;

% Transpose for Table format
obj.SpectralCrest =  scm.';
end