classdef cTeeDescs
%==========================================================================
% Base class for all Temporal Tnergy Envelope descriptors. 
%   INSTANTIATED BY: cTEErep < cTeeDescs
%==========================================================================

    properties (Abstract)
        % Create a consistent interface among subclasses
        RectifiedWav            % (in dBFS) Rectified waveform
        PowerEnvelope           % Power Envelope of squared waveform values
        NoiseTHD                % (in dBFS) Noise threshold.
        AttackTHD               % (in dBFS) xx dB below the max. level (=0 dBFS) of the waveform
        DecreaseSlopeTHD        % (in dBFS) Decrease Slope will be computed up to this THD.
        EffectiveDurationTHD    % (in dBFS) For calculating effective duration 
        Fs                      % (in Hz) Sampling Rate
    end
    
    properties 
        AttackTime
        LogAttackTime
        AttackSlope
        DecreaseSlope
        TemporalCentroid
        EffectiveDuration
        FrequencyOfEnergyModulation % Computed from method: energyModulation
        AmplitudeOfEnergyModulation % Computed from method: energyModulation
    end

    methods 
        function obj = cTeeDescs(~) % Constructor 
        end
        % Declare all methods
        obj = attackTime(obj);
        obj = attackSlope(obj);
        obj = decreaseSlope(obj);
        obj = temporalCentroid(obj);
        obj = effectiveDuration(obj);
        obj = energyModulation(obj);
    end
end