function obj = harmonicEnergy(obj)
%==========================================================================
% Computes the harmonic energy, noise energy, harmonic to noise energy,
% partials' to noise energy, and noisiness. 

% OBJ: cHARMrep

% CALLED BY: do_HARMrep.m
                
% MEMBER OF: cHarmDescs.m 
%==========================================================================

% Harmonic Energy
harmErg = sum(obj.HarmonicAmps.^2, 1);
% Partials' energy 
partErg = sum(obj.PartialsAmplitudes.^2, 1);
% Noise Energy
noiseErg = obj.TotalEnergy - partErg; 
% Noisiness
noisiness = noiseErg ./ obj.TotalEnergy;
% Harmonic to Noise Ratio (hnr): 
hnr = harmErg ./ noiseErg;
% Partials' energy to Noise Ratio (pnr): 
pnr = partErg ./ noiseErg;
% Avoid NaNs in silent frames:
noisiness(obj.TotalEnergy == 0) = 0;
hnr(noiseErg == 0) = 0;
pnr(noiseErg == 0) = 0;
 
% Transpose for Table format
obj.HarmonicEnergy          =  harmErg.';
obj.NoiseEnergy             =  noiseErg.';
obj.Noisiness               =  noisiness.';
obj.HarmonicToNoiseEnergy   =  hnr.';
obj.PartialsToNoiseEnergy   =  pnr.';
end