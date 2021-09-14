function obj = temporalCentroid(obj)
%==========================================================================
% Computes the temporal centroid. 

% OBJ: cTeerep

% CALLED BY: do_TEErep.m
                
% MEMBER OF: cTeeDescs.m 
%==========================================================================

stc     = find(obj.PowerEnvelope > 10.^(obj.NoiseTHD/10), 1);           % Start of temporal centroid
etc     = find(obj.PowerEnvelope > 10.^(obj.NoiseTHD/10), 1, 'last');   % End of temporal centroid
envtc   = obj.PowerEnvelope(stc:etc);                                   % Envelope part for calculating the TC
nsample = (1:length(envtc))'; 
tc      = (sum(envtc.*nsample) / sum(envtc)) / obj.Fs;                  % tc in seconds

obj.TemporalCentroid =  tc;
end