function waveform = preprocess_audioFile(waveform)
%==========================================================================
% Preprocess an audio file (WAVEFORM).

% 1. Keeps only one channel from the input according to max RMS level.
% 2. Removes the DC offset. 
% 3. Normalizes the audio file: [max(abs)) = 1]

% CALLED BY: TTdescriptors.m
%==========================================================================

% Check if the audio file is MONO    
if (size(waveform, 2) > 1)
    % Compare RMS levels
    if sqrt(mean(waveform(:,2).^2)) >  sqrt(mean(waveform(:,1).^2))
        waveform = waveform(:,2);
    else
        waveform = waveform(:,1);
    end      
end
% Remove DC offset
waveform = waveform - mean(waveform);
% Normalization
waveform = waveform/max(abs(waveform)); 