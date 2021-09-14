function env = amplitude_envelope(waveform, fs)
%==========================================================================
% Computes the amplitude envelope using local maxima and pchip
% interpolation.
% waveform: waveform to compute the envelope
% fs:       sampling rate
% env:      The extraxted amplitude envelope.

% CALLED BY: cTEErep.m (Constructor)
%==========================================================================


winLength_s   = 0.02;       % in ms
hopSize_s     = 0.01;       % in ms
% Convert to samples:
winLength   = round(winLength_s * fs); 
hopSize     = round(hopSize_s * fs);

nFrames     = ceil (length(waveform)/hopSize);
p           = zeros(nFrames, 1); % peaks
locs        = zeros(nFrames, 1); % location of the peaks

for i = 1:nFrames
    iStart              = (i-1)*hopSize + 1;
    iStop               = min(length(waveform), iStart + winLength - 1);
    iFrame              = waveform(iStart:iStop);
    [p(i), loc]         = max(iFrame);
    locs(i)             = loc + (iStart-1);
end

%--------------------------- Check points ---------------------------------
% Add the START end END points: --- but problem with "unique" for END points.
% (required for interpolation)
locs    = [1; locs];            % 1 is the index 1 of the rectWav. 
p       = [waveform(1); p];     % Add its value;
% Get unique values (required for interpolation) 
[locs, ia, ~]   = unique(locs);
p               = p(ia);
% So add the END point here, after the unique values are returned. 
locs           = [locs; length(waveform)];
p              = [p; waveform(end);];

% Make sure that the last two END locations values are unique.
if locs(end) == locs(end-1)
    locs(end-1)    = [];        % Keep the last point not the (end-1)
    p(end-1)       = [];
end

% Make sure that you have at least 4 points (required for interpolation).
if length(locs) < 4
    locs(end+1:4)  = (locs(end)+1) : (locs(end)+1) + (3-length(locs));
    p(end+1:4)     = 0;
end
    
%---------------------- Interpolation -------------------------------------
% Query points
xq          = 1:length(waveform);
xq          = xq(:);
env         = interp1(locs, p, xq, 'pchip');
env(env<0)  = 0;                    % Remove negative values (interpolation artifacts)
end