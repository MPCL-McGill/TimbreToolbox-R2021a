function [F, A] = spectrogram_to_peaks(S, fs, thd)
%==========================================================================
% Retunrs quad-interpolated local maxima of the spectrogram which are
% above a given threshold in dB (thd).

% S: magnitude spectrum (real)
% fs: sampling rate
% thd: Threshold in dBs
%      Only peaks above this threshold will be considered
%      in the quadratic interpolation (quadmaxloc.m)
% F: Frequency 
% A: Amplitude 

% CALLED BY: cHARMrep.m (Constructor)

% Disclaimer: This is a modification of the function 
% spectrogram2peaks.m found in:
% The DESAM Toolbox Package version 1.0
%==========================================================================


S = 20*log10(S); % Interpolate in dB's

% Initialization 
F = zeros(size(S));
% Initialize to -inf
A = -inf*ones(size(S)); % Because it will be converted back to linear scale

for k=1:size(S, 2) % Number of frames 
    [idx, a] = quadmaxloc(S(:, k).', thd); % Quadratic interpolation.

    % Peaks with higest magnitudes will be linked first.
    [a, x] = sort(a, 'descend');
    f = idx(x)/(2*(size(S, 1)-1))*fs; % Bin number to Hz.

    F((1:length(f)), k) = f;
    A((1:length(f)), k) = a;
end
A = 10.^(A/20); % Convert back to linear scale.

end