classdef cAsDescs
%==========================================================================
% Base class for all spectral audio descriptors. 
%   INSTANTIATED BY: cSTFTrep < cSpecDescs
%==========================================================================

    properties (Abstract)
        % Create a consistent interface among subclasses
        TimeStamps
        Zcr         % Zero Crossing Rate
        FrameEn     % Frame Energy
        RmsEn       % RMS Energy
        Acc         % Autocorrelation Coefficients
    end
    
    properties 
        ZeroCrossingRate
        FrameEnergy
        RMSenergy
        AutoCorrCoef_01
        AutoCorrCoef_02
        AutoCorrCoef_03
        AutoCorrCoef_04
        AutoCorrCoef_05
        AutoCorrCoef_06
        AutoCorrCoef_07
        AutoCorrCoef_08
        AutoCorrCoef_09
        AutoCorrCoef_10
        AutoCorrCoef_11
        AutoCorrCoef_12
        AutoCorrCoef_13
        AutoCorrCoef_14
        AutoCorrCoef_15
        AutoCorrCoef_16
        AutoCorrCoef_17
        AutoCorrCoef_18
        AutoCorrCoef_19
        AutoCorrCoef_20
    end

    methods 
        function obj = cAsDescs(~) % Constructor 
        end
        % Declare all methods
        obj = zeroCrossingRate(obj);
        obj = frameEnergy(obj);
        obj = rmsEnergy(obj);
        obj = autocorrelationCoefficients(obj); % Returns 20 coefficients
    end
end