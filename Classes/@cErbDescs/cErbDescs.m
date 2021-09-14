classdef cErbDescs
%==========================================================================
% Base class for all spectral audio descriptors. 
%   INSTANTIATED BY: cERBrep < cErbDescs
%==========================================================================

    properties (Abstract)
        % Create a consistent interface among subclasses
        RepValues 
        CenterFrequencies
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
        function obj = cErbDescs(~) % Constructor 
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