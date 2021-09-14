function [xmax,ymax] = quadmaxloc(v,th)
%==========================================================================
% [X,Y] = quadmaxloc(V,T)  
% Quadratic-interpolated index and values for local maxima.
% V is a uniformly-sampled vector. Find all local maxes above TH 
% (in dBFS), then do a quadratic fit to interpolate the location and 
% height of the maxima. Return these as correspoding elements of X and Y.
% The threshold (TH) is adjusted below the maximum level of V.  

% CALLED BY: spectrogram_to_peaks.m

% Disclaimer: This is a modification of the function 
% quadmaxloc.m by: 
% 1998may02 dpwe@icsi.berkeley.edu $Header: $ again?
%==========================================================================

th = th + max(v); % Adjust threshold with repsect to maximum.
nr = size(v, 2);
v(v<-90) = -inf;   % Set to -inf values below 90 dB
v(v==-inf) = th-1; % 1+v(nr) doesn't "work" with -Inf


% filter for local maxima; ensure edges don't win
gtl = (v > [v(1), v(1:(nr-1))]); 
gtu = (v >= [v(2:nr), 1+v(nr)]); % allow greater-than-or-equal to catch plateaux

vmax = v .* (v > th) .* gtl .* gtu;
maxixs = find(vmax);
% Interpolate the max pos's
xmax = zeros(size(maxixs));
ymax = zeros(size(maxixs));
for i = 1:size(maxixs,2)
  % Solve quadratic fit to 3 pts (as y = ax(x-b) with 0,0 as col(rmax-1))
  rmax = maxixs(i);
  y1 = v(rmax)-v(rmax-1);
  y2 = v(rmax+1)-v(rmax-1);
  a = (y2 - 2*y1)/2;
  b = 1-y1/a;
  xmax(i) = rmax-1+b/2;
  ymax(i) = v(rmax-1)-a*b*b/4;
end

end