function obj = harmonicSpectralDeviation(obj)
%==========================================================================
% Computes the harmonic spectral deviation. 

% OBJ: cHARMrep

% CALLED BY: do_HARMrep.m
                
% MEMBER OF: cHarmDescs.m 
%==========================================================================

% Global (smoothed) spectral envelope
specEnv = zeros(size(obj.HarmonicAmps)); 

if size(obj.HarmonicAmps, 1) > 2
    specEnv(1, :) = obj.HarmonicAmps(1, :);
    specEnv(2:end-1, :) = (obj.HarmonicAmps(1:end-2, :) + obj.HarmonicAmps(2:end-1, :) + obj.HarmonicAmps(3:end, :)) / 3;
    specEnv(end, :) = (obj.HarmonicAmps(end-1, :) + obj.HarmonicAmps(end, :)) / 2;
elseif size(obj.HarmonicAmps, 1) == 2
    specEnv(1, :) = obj.HarmonicAmps(1, :);
    specEnv(end, :) = (obj.HarmonicAmps(end-1, :) + obj.HarmonicAmps(end, :)) / 2;
else 
    specEnv(1, :) = obj.HarmonicAmps(1, :);
end
    
H = round(max(obj.HarmonicRank));% number of harmonics for a given frame
% Harmonic spectral deviation
hdev = sum(abs(obj.HarmonicAmps - specEnv), 1) ./ H;
% Replace NaNs with zeros (silent frames).
hdev(H == 0) = 0;
 
% Transpose for Table format
obj.HarmonicSpectralDeviation =  hdev.';

end