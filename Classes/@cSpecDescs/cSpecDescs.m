classdef cSpecDescs
%==========================================================================
% Base class for all spectral audio descriptors. 
%   INSTANTIATED BY: cSTFTrep < cSpecDescs
%==========================================================================

    properties (Abstract)
        % Create a consistent interface among subclasses
        RepValues 
        FrequencyBins
        TimeStamps
    end
    
    properties 
        SpectralCentroid
        SpectralSpread
        SpectralSkewness
        SpectralKurtosis
        SpectralFlatness
        SpectralCrest
        SpectralSlope
        SpectralDecrease
        SpectralRollOff
        SpectralVariation
        SpectralFlux
    end

    methods 
        function obj = cSpecDescs(~) % Constructor 
        end
        % Declare all methods
        obj = spectralCentroid(obj);
        obj = spectralSpread(obj);
        obj = spectralSkewness(obj);
        obj = spectralKurtosis(obj);
        obj = spectralFlatness(obj);
        obj = spectralCrest(obj);
        obj = spectralSlope(obj);
        obj = spectralDecrease(obj);
        obj = spectralRollOff(obj);
        obj = spectralVariation(obj);
        obj = spectralFlux(obj);
    end
end