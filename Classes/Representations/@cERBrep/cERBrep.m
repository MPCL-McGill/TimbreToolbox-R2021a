classdef cERBrep < cErbDescs
%==========================================================================
% Computes the ERB representation: 
% ERBrep

% WAVEFORM, FS: The waveform and sampling rate 
% CONFIG: Configuration parameters
% DESCS: Which audio descriptors to compute
%   INSTANTIATED BY: do_ERBrep.m
%==========================================================================
properties 
    % Defined in superclass as Abstract
    RepValues 
    CenterFrequencies
    TimeStamps
end

methods  
    
    [s] = erbObj_to_struct(obj);
    
    function obj = cERBrep(waveform, fs, config, descs) % Constructor
    
     % ======================== Parameters ================================
    if isfield(config, 'winLength_s')   % If in seconds    
        winLength   = round(config.winLength_s * fs); % Convert to samples
        hopSize     = floor(config.hopSize_s * fs);
    else    % is in samples
        winLength   = config.winLength;
        hopSize     = config.hopSize;
    end
    
    fLow            = config.fLow;
    nChannels       = config.nChannels; 
    fHigh           = fs/2;
    earQ            = 9.26449;				
    minBW           = 24.7;
    order           = 1;
    T               = 1/fs;
    nFrames         = ceil (length(waveform)/hopSize);
    t               = ((0:nFrames-1) * hopSize + (winLength/2))/fs; % Time stamps
    ERBval          = zeros(nChannels, nFrames);
        
        
    % Do the ERB representaion: Get the ERB values.
    % ==================== Center Frequencies =============================
    % >>>>>>>>>> ERBSpace.m from Slaneys Auditory Toolbox <<<<<<<<<<<<<<< % 
    fc = -(earQ*minBW) + exp((1:nChannels)' * (-log(fHigh + earQ*minBW) + ...
        log(fLow + earQ*minBW)) / nChannels) * (fHigh + earQ*minBW);
    fc = flipud(fc);
    
    % ========================= Filter Coeffs =============================
    % >>>>>>>>>> MakeERBFilters.m from Slaneys Auditory Toolbox <<<<<<<<< %    
    ERB = ((fc/earQ).^order + minBW^order).^(1/order);
    B   = 1.019*2*pi*ERB;
    % compute the coefficients
    [afCoeffB, afCoeffA] = get_filterCoeffs(fc, B, T);
    
    % ========================== Filtering ================================
    % >>>>>>>>>> ERBFilterBank.m from Slaneys Auditory Toolbox <<<<<<<<<< %    
    for k = 1:nChannels
        temp  = waveform;
        for j = 1:4
            temp = filter(afCoeffB(j,:,k), afCoeffA(j,:,k), temp); % k^th channel
        end
        
        % ==================== Energy Integration =====================
        temp            = temp .* temp;
        for n = 1:nFrames
            nStart      = (n-1)*hopSize + 1;
            nStop       = min(length(waveform), nStart + winLength - 1);
            nFrame      = temp(nStart:nStop);
            ERBval(k,n) = sqrt(mean(nFrame));
        end   
    end
    clear temp

        % Object Initialization
        obj                     = obj@cErbDescs(descs);

        % Post-Initialization
        obj.RepValues           = ERBval; 
        obj.CenterFrequencies   = fc;
        obj.TimeStamps          = t.'; % Transpose for exporting to Table array.      
        end
end 
end