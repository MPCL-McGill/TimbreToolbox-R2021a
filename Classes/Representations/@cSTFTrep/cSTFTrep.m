classdef cSTFTrep < cSpecDescs
%==========================================================================
% Computes the STFT for both representations: 
% PowSTFTrep and MagSTFTrep

% WAVEFORM, FS: The waveform and sampling rate 
% CONFIG: Configuration parameters
% DESCS: Which audio descriptors to compute
%   INSTANTIATED BY: do_PowSTFTrep.m
%                    do_MagSTFTrep.m
%==========================================================================
properties 
    % Defined in superclass as Abstract
    RepValues 
    FrequencyBins
    TimeStamps
end

methods  
    
    [s] = stftObj_to_struct(obj);
    
    % Constructor
    function obj = cSTFTrep(waveform, fs, config, descs)
        
        if isfield(config, 'winLength_s')   % If in seconds    
            winLength   = round(config.winLength_s * fs); % Convert to samples
            hopSize     = floor(config.hopSize_s * fs);
        else    % is in samples
            winLength   = config.winLength;
            hopSize     = config.hopSize;
        end

        % Pre-Initialization
        if strcmp(config.winType, 'rectwin') % Can't be 'periodic'.
            winType = rectwin(winLength);
        else
        winType = feval(config.winType, winLength, 'periodic');
        end
        overlap = winLength - hopSize;
        nfft    = max(256,2^nextpow2(winLength)); 

        % Waveform must be >= than winLength
        if length(waveform) < winLength
            warning('The audio file has shorter duration than the analysis window. \n%s',...
                'Doing Zero-padding.')
            padsize = winLength - length(waveform);
            waveform  = [waveform; zeros(padsize,1)];
        end
        
        % Do the STFT: Get the amplitude spectrum.
        [s, f, t] = spectrogram(waveform, winType, overlap, nfft, fs);
        s = abs(s)/winLength; 
        s(2:end-1,:) = 2*s(2:end-1,:);
        
        % Object Initialization
        obj = obj@cSpecDescs(descs);

        % Post-Initialization
        obj.RepValues       = s; 
        obj.FrequencyBins   = f;
        obj.TimeStamps      = t.'; % Transpose for exporting to Table array.      
        end
end 
end