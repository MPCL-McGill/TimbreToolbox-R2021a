classdef cTEErep < cTeeDescs
%==========================================================================
% Computes the rectified waveform in power (dBFS) and the power envelope 
% of squared waveform values for the TEErep. 

% WAVEFORM, FS: The waveform and sampling rate 
% CONFIG: Configuration parameters
% DESCS: Which audio descriptors to compute
%   INSTANTIATED BY: do_TEErep.m
%==========================================================================
properties 
    % Defined in superclass as Abstract
    RectifiedWav            % (in power dBFS) Rectified waveform
    PowerEnvelope           % Power Envelope (squared waveform values)
    NoiseTHD                % (in dBFS) Noise threshold.
    AttackTHD               % (in dBFS) xx dB below the max. level (=0 dBFS) of the waveform.
    DecreaseSlopeTHD        % (in dBFS) Decrease Slope will be computed up to this THD.
    EffectiveDurationTHD    % (in dBFS) For calculating effective duration
    Fs                      % (in Hz) Sampling Rate
end

methods  
    
    [s] = teeObj_to_struct(obj);
    
    function obj = cTEErep(waveform, fs, config, descs) % Constructor
        
        env         = amplitude_envelope(waveform.^2, fs);
        env         = env/max(abs(env));        % Normalization
        
        % Object Initialization
        obj = obj@cTeeDescs(descs);

        % Post-Initialization
        obj.RectifiedWav            = 20*log10(abs(waveform)); 
        obj.PowerEnvelope           = env;
        obj.NoiseTHD                = config.noiseTHD;                 
        obj.AttackTHD               = config.attackTHD;              
        obj.DecreaseSlopeTHD        = config.decreaseSlopeTHD;       
        obj.EffectiveDurationTHD    = config.effectiveDurationTHD;  
        obj.Fs                      = fs;

        end
end 
end