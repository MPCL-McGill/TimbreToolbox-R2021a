function obj = decreaseSlope(obj)
%==========================================================================
% Computes the decrease slope. 

% OBJ: cTeerep

% CALLED BY: do_TEErep.m
                
% MEMBER OF: cTeeDescs.m 
%==========================================================================
decreaseSlopeTHD = -12;                     % (in dBFS) Decrease Slope will be computed up to this THD.

[sdecv, sdec]   = max(obj.RectifiedWav);    % Start of decrease (value(in dB) and sample#).
edec            = find(obj.RectifiedWav > decreaseSlopeTHD, 1, 'last');
edec            = edec + 1;                 % Now the decreaseSlopeTHD is actually crossed.

if (edec <= sdec) || (edec > length(obj.RectifiedWav))  % 2nd statement because of +1
    decSlope = 0;                                       % Is not decreasing
else
    edecv       = obj.RectifiedWav(edec);
    decSlope    = (sdecv - edecv) / ((sdec - edec)/obj.Fs); % Denominator in seconds.
end

obj.DecreaseSlope =  decSlope;
end