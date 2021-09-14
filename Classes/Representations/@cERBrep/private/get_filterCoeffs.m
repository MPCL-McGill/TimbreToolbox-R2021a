function [afCoeffB, afCoeffA] = get_filterCoeffs(fc, B, T)
%==========================================================================
% Returns the gammatone filter coefficients. 
% CALLED BY: cERBrep.m (Constructor)

% Disclaimer: see also
% MakeERBFilters.m from Slaneys Auditory Toolbox.   
% This version is from Alexander Lerch:
% Matlab sources accompanying the book
% An Introduction to Audio Content Analysis - 
% Applications in Signal Processing and Music Informatics
% by Alexander Lerch, info@AudioContentAnalysis.org
%==========================================================================
    fCos    = cos(2*fc*pi*T);
    fSin    = sin(2*fc*pi*T);
    fExp    = exp(B*T);
    fSqrtA  = 2*sqrt(3+2^1.5);
    fSqrtS  = 2*sqrt(3-2^1.5);

    A0      = T;
    A2      = 0;
    B0      = 1;
    B1      = -2*fCos./fExp;
    B2      = exp(-2*B*T);

    A11     = -(2*T*fCos./fExp + fSqrtA*T*fSin./ fExp)/2;
    A12     = -(2*T*fCos./fExp - fSqrtA*T*fSin./ fExp)/2;
    A13     = -(2*T*fCos./fExp + fSqrtS*T*fSin./ fExp)/2;
    A14     = -(2*T*fCos./fExp - fSqrtS*T*fSin./ fExp)/2;

    fSqrtA  = sqrt(3 + 2^(3/2));
    fSqrtS  = sqrt(3 - 2^(3/2));
    fArg    = i*fc*pi*T;
    
    afGain    = ...
    abs((-2*exp(4*fArg)*T+2*exp(-(B*T)+2*fArg).*T.*(fCos-fSqrtS*fSin)).* ...
        (-2*exp(4*fArg)*T+2*exp(-(B*T)+2*fArg).*T.*(fCos+fSqrtS*fSin)).* ...
        (-2*exp(4*fArg)*T+2*exp(-(B*T)+2*fArg).*T.*(fCos-fSqrtA*fSin)).* ...
        (-2*exp(4*fArg)*T+2*exp(-(B*T)+2*fArg).*T.*(fCos+fSqrtA*fSin))./ ...
        (-2 ./ exp(2*B*T) - 2*exp(4*fArg) + 2*(1 + exp(4*fArg))./fExp).^4);

    % this is Slaneys compact format - now resort into 3D Matrices
    % fcoefs = [A0*ones(length(f_c),1) A11 A12 A13 A14 A2*ones(length(f_c),1) B0*ones(length(f_c),1) B1 B2 afGain];
    
    afCoeffB = zeros(4,3,length(B));    
    afCoeffA = zeros(4,3,length(B));
    
    for k = 1:length(B)
        afCoeffB(1,:,k)     = [A0 A11(k) A2]/afGain(k);
        afCoeffA(1,:,k)     = [B0 B1(k) B2(k)];
        
        afCoeffB(2,:,k)     = [A0 A12(k) A2];
        afCoeffA(2,:,k)     = [B0 B1(k) B2(k)];
        
        afCoeffB(3,:,k)     = [A0 A13(k) A2];
        afCoeffA(3,:,k)     = [B0 B1(k) B2(k)];
        
        afCoeffB(4,:,k)     = [A0 A14(k) A2];
        afCoeffA(4,:,k)     = [B0 B1(k) B2(k)];
        
    end
end