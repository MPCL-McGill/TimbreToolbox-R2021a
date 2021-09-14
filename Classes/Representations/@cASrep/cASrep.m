classdef cASrep < cAsDescs
%==========================================================================
% Does the windowing and returns the zeroCrossingRate 
% and autocorrelationCoefficients for the: 
% ASrep 

% WAVEFORM, FS: The waveform and sampling rate 
% CONFIG: Configuration parameters
% DESCS: Which audio descriptors to compute
%   INSTANTIATED BY: do_ASrep.m
%==========================================================================
properties 
    % Defined in superclass as Abstract
    TimeStamps
    Zcr         % Zero Crossing Rate
    FrameEn     % Frame Energy
    RmsEn       % RMS Energy
    Acc         % Autocorrelation Coefficients    
end

methods
    
    [s] = asObj_to_struct(obj);
        
    function obj = cASrep(waveform, fs, config, descs)  % Constructor 
        
        if isfield(config, 'winLength_s')                   % If in seconds    
            winLength   = round(config.winLength_s * fs);   % Convert to samples
            hopSize     = round(config.hopSize_s * fs);
        else    % is in samples
            winLength   = config.winLength;
            hopSize     = config.hopSize;
        end

        % Pre-Initialization

%         % Waveform must be >= than winLength
%         if length(waveform) < winLength
%             warning('The audio file has shorter duration than the analysis window. \n%s',...
%                 'Doing Zero-padding.')
%             padsize = winLength - length(waveform);
%             waveform  = [waveform; zeros(padsize,1)];
%         end

        % Do the windowing and compute descriptors.
        nFrames     = ceil (length(waveform)/hopSize);
        t           = ((0:nFrames-1) * hopSize + (winLength/2))/fs; % Time stamps
        zcr         = zeros(1,nFrames);                             % Zero Crossing Rate
        nCoeffs     = 20;                                           % Number of autocorrelation coeffs to keep
        acc         = zeros(nCoeffs, nFrames);                      % Autocorrelation Coefficients
        frameEn     = zeros(1,nFrames);                             % Frame Energy
        rmsEn       = zeros(1,nFrames);                             % RMS Energy
        
        for i = 1:nFrames
            i_start     = (i-1)*hopSize + 1;
            i_stop      = min(length(waveform),i_start + winLength - 1);
            ithFrame    = waveform(i_start:i_stop);

            % =================== Zero Crossing Rate ======================
            ithFrameNoDC    = ithFrame - mean(ithFrame);  % Remove DC
            zcr(i)          = 0.5*mean(abs(diff(sign(ithFrameNoDC))));
            
            % =================== Frame Energy ============================
            frameEn(i)      = sum(ithFrame.^2);
            
            % ===================== RMS Energy ============================
            rmsEn(i)        = sqrt(mean(ithFrame.^2));

            % ============== Autocorrelation Coefficients =================
            if (sum(waveform(i_start:i_stop)) == 0) % Avoid NaN
                afCorr = zeros(2*(i_stop-i_start)+1,1);
            else
                afCorr = xcorr(waveform(i_start:i_stop), 'coeff');
            end
            afCorr  = afCorr((ceil((length(afCorr)/2))+1):end);
            % afCorr  = fftshift(xcorr(waveform(i_start:i_stop), 'coeff'));
            if length(afCorr) < nCoeffs
                afCorr(end+1:nCoeffs) = 0;
            end 
            acc(:, i) = afCorr(1:nCoeffs); % Keep only nCoeffs
            
        end

        % Object Initialization
        obj = obj@cAsDescs(descs);

        % Post-Initialization
        obj.TimeStamps      = t.'; % Transpose for exporting to Table array. 
        obj.Acc             = acc.';
        obj.Zcr             = zcr.';
        obj.FrameEn         = frameEn.';
        obj.RmsEn           = rmsEn.';
        end
end 
end