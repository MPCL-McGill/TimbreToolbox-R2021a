function obj = spectralCrest(obj)
%==========================================================================
% Spectral crest measure (scm). 

% OBJ: cHARMrep

% CALLED BY: do_HARMrep.m
                
% MEMBER OF: cHarmDescs.m 
%==========================================================================

% Peeters formulation:
% scm = max(obj.PartialsAmplitudes,[],1) ./ (mean(obj.PartialsAmplitudes, 1));

% Or use the sum instead: restrict values in the range: 2/nBins to 1:
scm = max(obj.PartialsAmplitudes,[],1) ./ (sum(obj.PartialsAmplitudes, 1));

% Replace NaNs with zeros (silent frames).
scm( sum(obj.PartialsAmplitudes,1) == 0) = 0;

% Transpose for Table format
obj.SpectralCrest =  scm.';
end