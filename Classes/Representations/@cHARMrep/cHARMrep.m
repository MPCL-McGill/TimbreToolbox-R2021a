 classdef cHARMrep < cHarmDescs
%==========================================================================
% Computes the STFT and does partial tracking for the harmonic representation: 
% HARMrep 

% WARNINGS:
% 1) The waveform gets time-reversed so special attention should be given
% to property - variables.
% 2) swipep.m can cause errors for certain pitch ranges. It can also be
% erroneous with synthetic and polyphonic signals.

% WAVEFORM, FS: Input signal and sampling rate 
% CONFIG:       Configuration parameters
% DESCS:        Which audio descriptors to compute

%   INSTANTIATED BY: do_HARMrep.m
%==========================================================================
properties 
    % Defined in superclass as Abstract
    PartialsAmplitudes 
    PartialsFrequencies
    HarmonicRank
    HarmonicFreqs
    HarmonicAmps
    TotalEnergy
    TimeStamps
    Pitch
end

methods 
    [s] = harmObj_to_struct(obj);
    
function obj = cHARMrep(waveform, fs, config, descs) % Constructor 

% -------------------- STFT configuration ---------------------------------
    if isfield(config, 'winLength_s')   % If in seconds    
        winLength   = round(config.winLength_s * fs); % Convert to samples
        hopSize     = floor(config.hopSize_s * fs);
    else            % is in samples
        winLength   = config.winLength;
        hopSize     = config.hopSize;
    end

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
        padsize     = winLength - length(waveform);
        waveform    = [waveform; zeros(padsize,1)];
    end
% ---------------- End of STFT configuration ------------------------------
    
    % Time reversal    
    waveform = flipud(waveform); 

    % Do the STFT: Get the amplitude spectrum.
    [s, ~, t]       = spectrogram(waveform, winType, overlap, nfft, fs);
    s               = abs(s)/winLength; 
    s(2:end-1,:)    = 2*s(2:end-1,:);
    totalEnergy     = sum(s.^2, 1);
    totalEnergy     = fliplr(totalEnergy); % waveform is time reversed
    clear winType

    
% ------------- Chunk size and Partial Tracking configuration -------------
    % Other initializations
    frameLength     = length(waveform)/length(t);   % In samples
    minDur          = round( (config.minPartialsDuration*fs)/frameLength ); % In frames
    maxChunkLength  = 20;                           % In frames
    nPartials       = 0;                            % Number of tracked partials (gets updated from peaks_to_partials.m)
% ---------End of Chunk size and Partial Tracking configuration -----------


% ------------------- spectrogram_to_peaks.m ------------------------------
    [F, A] = spectrogram_to_peaks(s, fs, config.magnitudeThreshold);
    % Remove if all row is made of zeros (i.e peaks below magnitudeThreshold)
    rowidx          = ~any(F, 2); % 0 = If any of the row elements are non-zero (true)
    F(rowidx, :)    = [];
    A(rowidx, :)    = [];
    clear s rowidx % Don't need the STFT data (except from t (=TimeStamps) )    

    
% ----------------- peaks_to_partials.m in chunks -------------------------
    if (size(A,2) > maxChunkLength) && ~isempty(A) % (Maybe all peaks are < magnitudeThreshold)
        chunkLengths = maxChunkLength * ones(1, floor(size(A, 2)/maxChunkLength));
        r = mod(size(A, 2), maxChunkLength);
        if r > 0
          chunkLengths(end+1) = r;
        end
        Achunks = mat2cell(A, size(A,1), chunkLengths);   
        Fchunks = mat2cell(F, size(F,1), chunkLengths);
        % Do the 1st chunk
        [P, Zi, Zf, trC, nPartials] = peaks_to_partials ...
        (Fchunks{1,1});
        % And then the rest
        for i = 2:size(Achunks, 2)
            [temp, Zi, Zf, trC, nPartials] = peaks_to_partials...
            (Fchunks{1,i}, Zi, Zf, trC, nPartials);
            P = [P, temp]; 
        end
        clear temp Zi Zf trC Achunks Fchunks chunkLengths
    elseif  ~isempty(A) % Don't do in chunks
        [P, ~, ~, ~, nPartials] = peaks_to_partials(F); 
    end

    
% ---------------- Partials' indexes (P) to cell array --------------------
    if nPartials > 0 % If there are tracked partials from peaks_to_partials.m
        nPartials = nPartials-1; % peaks_to_partials returns n+1 partials
        partials = cell(nPartials, 5);
        k = 0; % index for partials that satisfy minDur
        for i=1:nPartials
            [l, c] = find(P==i); 
            linidx = sub2ind(size(F), l, c); % Convert to linear index

            % Partial's duration in frames.
            durFrames = length(c(1):c(end)); 

            if durFrames >= minDur
                k = k+1;
                % NaN's are used for interpolating missing (zombie) frames.
                partials{k,1} = NaN * ones(durFrames, 1); % Partials' frequencies
                partials{k,2} = NaN * ones(durFrames, 1); % Partials' amplitudes

                idxFromStart                = c - c(1) + 1; % Partials begin at cell(i ,1)
                partials{k,1}(idxFromStart) = F(linidx);    % Partials' frequencies
                partials{k,2}(idxFromStart) = A(linidx);    % Partials' amplitudes
                partials{k,3}               = c(1);         % Partials' birth frames
                partials{k,4}               = c(end);       % Partials' death frames
                partials{k,5}               = durFrames;    % Partials' duration

                % ----------------- Interpolate NaNs ----------------------
                % Frequency
                x = partials{k,1}; nanx = isnan(x); w = 1:numel(x);
                x(nanx) = interp1(w(~nanx), x(~nanx), w(nanx));
                partials{k,1} = x;
                % Amplitude
                x = partials{k,2}; nanx = isnan(x); 
                x(nanx) = interp1(w(~nanx), x(~nanx), w(nanx));
                partials{k,2} = x; 
            end % Keep partials >= minDur
        end % No more partials left to check
        clear A F P x nanx w idxFromStart
    % Remove partials < minDur (empty cells)
    partials(cellfun('isempty', partials(:,1)), :) = [];
    else
        partials = [];
        warning('No partials found using the current settings of HARMrep.');
    end % If npartials > 0

    
% ---------------- Partials' to freqs - amps array ------------------------
    if ~isempty(partials)
        % Frequency - Amplitude arrays (freqs, amps):
        xdim    = size(partials,1); % how many partials
        ydim    = length(t); % Frames of the STFT
        freqs   = zeros(xdim, ydim);
        amps    = zeros(xdim, ydim);
        for i = 1:size(partials,1)
            birth                   = partials{i, 3};
            death                   = partials{i, 4};
            freqs(i, birth:death)   = partials{i, 1}.';
            amps(i, birth:death)    = partials{i, 2}.';
        end
        freqs   = fliplr(freqs); % waveform is time-reversed
        amps    = fliplr(amps);  % waveform is time-reversed
        clear partials xdim ydim
    else 
        freqs   = zeros(1, length(t));
        amps    = zeros(1, length(t));
        warning('No partials found using the current settings of HARMrep.');
    end
    
    if size(amps,1) > 1 % (if size(amps,1) == 1, no need to sort)
        % Sort frequencies: Needed for calculating spectral descs.
        [freqs, idx] = sort(freqs);
        % Rearrange amplitudes according to sorted freqs
        for c = 1:size(amps,2) 
            amps(:,c) = amps(idx(:,c), c);
        end
    end
    clear idx

    % Remove rows with all zeros
    rowidx              = ~any(freqs, 2);
    freqs(rowidx, :)    = [];
    amps(rowidx, :)     = [];
    clear rowidx

% -------------------- Pitch estimation: swipep.m -------------------------

pitchEst = swipep(waveform, fs, config.pitchRange, t(2) - t(1));
if length(pitchEst) > length(t)
    pitchEst(length(t)+1:end) = [];
else
    pitchEst(end:length(t)) = pitchEst(end);
end
pitchEst = flipud(pitchEst); % waveform is time-reversed


% --------------------------- Find Harmonics ------------------------------
    % Frequencies to Harmonic Rank
    harmRank        = freqs ./ pitchEst';
    checkTolerance  = abs(harmRank - round(harmRank)) <= config.inharmonicityTolerance;
    % Set inharmonics to zero
    harmRank        = harmRank.*checkTolerance;
    harmFreqs       = freqs.*checkTolerance;
    harmAmps        = amps.*checkTolerance;
    clear checkTolerance;
    
    % Sort arrays
    if size(amps,1) > 1 % (if size(amps,1) == 1, no need to sort)
        harmRank            = sort(harmRank);
        [harmFreqs, idx]    = sort(harmFreqs);
        % Rearrange amplitudes according to sorted freqs
        for c = 1:size(harmAmps,2) 
            harmAmps(:,c)   = harmAmps(idx(:,c), c);
        end
    end
    clear idx;
    
    % Avoid (fake) 'subharmonics' caused by conditioning inhTolerance:
    harmRank(harmRank < 1 - config.inharmonicityTolerance) = 0; 
    linIdx              = find(~harmRank);  
    harmFreqs(linIdx)   = 0;
    harmAmps(linIdx)    = 0;
    clear linIdx
    
    % Remove rows with all zeros
    rowidx                  = ~any(harmRank, 2);
    harmRank(rowidx, :)     = [];
    harmFreqs(rowidx, :)    = [];
    harmAmps(rowidx, :)     = [];
    clear rowidx
    

if ~isempty(harmFreqs)
%--------------------- The sound is Harmonic ------------------------------
    % >>>>> There might be more than two partials for a given harmonic <<<<
    % >>>>>>>>>>>>>>>>>>>> which satisfy inhTolerance. <<<<<<<<<<<<<<<<<<<<
    
    % Initialize arrays that will contain the unique harmonics (U)
    maxRank     = round(max(max(harmRank)));
    nbFrames    = size(harmRank, 2);
    harmRankU   = zeros(maxRank, nbFrames); % U: unique elements
    harmFreqsU  = zeros(maxRank, nbFrames); 
    harmAmpsU   = zeros(maxRank, nbFrames); 
    clear maxRank nbFrames
    
    for k = 1: size(harmRank, 2)
        tempRank    = harmRank(:,k);    tempRank(tempRank==0)   = [];
        tempAmp     = harmAmps(:,k);    tempAmp(tempAmp==0)     = [];
        tempFreq    = harmFreqs(:,k);   tempFreq(tempFreq==0)   = [];
        % Round to ideal (integer) harmonic
        r = (round(tempRank)); % Rounded harmonic rank - will be used as row index.
        
        if length(unique(r)) == length(tempRank) % temp has unique harmonics
        % ------------------ one Partial per Harmonic ---------------------
            harmRankU(r, k)     = tempRank; % Harmonics aggree with row idx
            harmFreqsU(r, k)    = tempFreq;
            harmAmpsU(r, k)     = tempAmp;            
        else
        % ------------- Duplicates: more than one Partial per Harmonic ----
            [~,ir,~] = unique(r);
            % Find all repeated harmonics
            repeatedHarms = unique(r(setdiff( (1:length(r)),ir) ));

            for h = 1:length(repeatedHarms)
                indexes = find(r == repeatedHarms(h));
                % Pick the one which has the max. amplitude - (Ignore case
                % in which duplicates have the same max. amplitude)
                maxAmp = max(tempAmp(indexes)); 
                % idxRemove: Point to indexes of repeated harmonics:
                % idxRemove = find(tempAmp(indexes) < maxAmp);
                idxRemove = tempAmp(indexes) < maxAmp;
                % ------------- Remove the duplicates ---------------------
                % indexes(idxRemove): Point back to the orginal indexes
                r(indexes(idxRemove))           = []; % row index.
                tempRank(indexes(idxRemove))    = [];
                tempFreq(indexes(idxRemove))    = [];
                tempAmp(indexes(idxRemove))     = [];
            end % For each harmonic duplicate
            % Update unique harmonics
            harmRankU(r, k)     = tempRank;
            harmFreqsU(r, k)    = tempFreq;
            harmAmpsU(r, k)     = tempAmp;
        end % Checking for harmonic duplicates   
    end % End of frames
    
    clear tempRank tempFreq tempAmp harmRank harmAmps harmFreqs
    % And other garbage:
    clear birth c death durFrames frameLength h hopSize i idxRemove indexes ir k l linidx maxAmp
    clear maxChunkLength minDur r repeatedHarms 
    
else
% --------------------- The sound is Inharmonic ---------------------------
    warning('No harmonics found within the limits of inharmonicityTolerance with respect to pitchRange');
    harmRankU     = zeros(1, length(t));
    harmFreqsU    = zeros(1, length(t));
    harmAmpsU     = zeros(1, length(t));
end % If the sound is Harmonic

    % Object Initialization
    obj = obj@cHarmDescs(descs);

    % Post-Initialization
    obj.PartialsAmplitudes      = amps; 
    obj.PartialsFrequencies     = freqs;
    obj.TimeStamps              = t.'; % Transpose for exporting to Table array.      
    obj.Pitch                   = pitchEst;
    obj.TotalEnergy             = totalEnergy;
    obj.HarmonicRank            = harmRankU; % One partial per harmonic rank.
    obj.HarmonicFreqs           = harmFreqsU;
    obj.HarmonicAmps            = harmAmpsU;
    
end % Constructor

end % Methods

end