classdef cHarmDescs
%==========================================================================
% Base class for all spectral audio descriptors. 
%   INSTANTIATED BY: cSTFTrep < cSpecDescs
%==========================================================================

    properties (Abstract)
        % Create a consistent interface among subclasses
        PartialsAmplitudes 
        PartialsFrequencies
        HarmonicRank
        HarmonicFreqs
        HarmonicAmps
        TotalEnergy
        TimeStamps
        Pitch
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
        HarmonicSpectralDeviation
        Tristimulus_1               % Returned from: tristimulusValues(obj)
        Tristimulus_2               % Returned from: tristimulusValues(obj)
        Tristimulus_3               % Returned from: tristimulusValues(obj)
        HarmonicOddToEvenRatio
        Inharmonicity
        HarmonicEnergy              % Returned from: harmonicEnergy(obj)
        NoiseEnergy                 % Returned from: harmonicEnergy(obj)
        Noisiness                   % Returned from: harmonicEnergy(obj)
        HarmonicToNoiseEnergy       % Returned from: harmonicEnergy(obj)
        PartialsToNoiseEnergy       % Returned from: harmonicEnergy(obj)
    end

    methods 
        function obj = cHarmDescs(~) % Constructor 
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
        obj = harmonicSpectralDeviation(obj);
        obj = tristimulusValues(obj);
        obj = harmonicOddToEvenRatio(obj);
        obj = inharmonicity(obj);
        obj = harmonicEnergy(obj);  
    end
end