function SelDescs(src,event, itAllDescs, itTEErep, itPowSTFTrep, itMagSTFTrep, itHARMrep, itERBrep, itASrep) 
% Select Audio Descriptors.

    % Turn off the 'ALL' option and update the field. 
    itAllDescs.Checked = 'off';
    itAllDescs.UserData = [];
    
    % Open the new menu
    fig = uifigure('Name', 'Select Audio Descriptors','HandleVisibility', 'on');
    
    % ====== Check/Uncheck descriptors according to representations =======    
    if isempty(itPowSTFTrep.UserData) && isempty(itMagSTFTrep.UserData) && isempty(itHARMrep.UserData) && isempty(itERBrep.UserData) 
        flagSpecDescs = 'off';
    else
        flagSpecDescs = 'on';
    end
    
    if isempty(itASrep.UserData)  
        flagAsDescs = 'off';
    else
        flagAsDescs = 'on';
    end 
    
    if isempty(itTEErep.UserData)  
        flagTeeDescs = 'off';
    else
        flagTeeDescs = 'on';
    end  
    
    if isempty(itHARMrep.UserData)  
        flagHarmDescs = 'off';
    else
        flagHarmDescs = 'on';
    end     

    % ======================= List all Descriptors ========================

    % Spectral Descriptors
    cbx_spectralCentroid    = uicheckbox(fig, 'Text','spectralCentroid',    'Enable', flagSpecDescs, 'Position',    [20 350 200 22]);
    cbx_spectralCrest       = uicheckbox(fig, 'Text','spectralCrest',       'Enable', flagSpecDescs, 'Position',    [20 320 200 22]);
    cbx_spectralDecrease    = uicheckbox(fig, 'Text','spectralDecrease',    'Enable', flagSpecDescs, 'Position',    [20 290 200 22]);
    cbx_spectralFlatness    = uicheckbox(fig, 'Text','spectralFlatness',    'Enable', flagSpecDescs, 'Position',    [20 260 200 22]);
    cbx_spectralFlux        = uicheckbox(fig, 'Text','spectralFlux',        'Enable', flagSpecDescs, 'Position',    [20 230 200 22]);
    cbx_spectralKurtosis    = uicheckbox(fig, 'Text','spectralKurtosis',    'Enable', flagSpecDescs, 'Position',    [20 200 200 22]);
    cbx_spectralRollOff     = uicheckbox(fig, 'Text','spectralRollOff',     'Enable', flagSpecDescs, 'Position',    [20 170 200 22]);
    cbx_spectralSkewness    = uicheckbox(fig, 'Text','spectralSkewness',    'Enable', flagSpecDescs, 'Position',    [20 140 150 22]);
    cbx_spectralSlope       = uicheckbox(fig, 'Text','spectralSlope',       'Enable', flagSpecDescs, 'Position',    [20 110 200 22]);
    cbx_spectralSpread      = uicheckbox(fig, 'Text','spectralSpread',      'Enable', flagSpecDescs, 'Position',    [20 80  200 22]);
    cbx_spectralVariation   = uicheckbox(fig, 'Text','spectralVariation',   'Enable', flagSpecDescs, 'Position',    [20 50  200 22]); 
    % Temporal Energy Envelope Descriptors
    cbx_attackSlope         = uicheckbox(fig, 'Text','attackSlope',         'Enable', flagTeeDescs, 'Position',     [190 350 200 22]); 
    cbx_attackTime          = uicheckbox(fig, 'Text','attackTime',          'Enable', flagTeeDescs, 'Position',     [190 320 200 22]); 
    cbx_decreaseSlope       = uicheckbox(fig, 'Text','decreaseSlope',       'Enable', flagTeeDescs, 'Position',  	[190 290 200 22]); 
    cbx_effectiveDuration   = uicheckbox(fig, 'Text','effectiveDuration',   'Enable', flagTeeDescs, 'Position',     [190 260 200 22]); 
    cbx_energyModulation    = uicheckbox(fig, 'Text','energyModulation',    'Enable', flagTeeDescs, 'Position',     [190 230 200 22]); 
    cbx_temporalCentroid    = uicheckbox(fig, 'Text','temporalCentroid',    'Enable', flagTeeDescs, 'Position',     [190 200 200 22]); 
    % Audio Signal Descriptors
    cbx_autocorrelationCoefficients     = uicheckbox(fig, 'Text','autocorrelationCoefficients', 'Enable', flagAsDescs,  'Position', [190 140 200 22]);         
    cbx_zeroCrossingRate                = uicheckbox(fig, 'Text','zeroCrossingRate',            'Enable', flagAsDescs,  'Position',	[190 110 200 22]);         
    cbx_frameEnergy                     = uicheckbox(fig, 'Text','frameEnergy',                 'Enable', flagAsDescs,  'Position',	[190 80 200 22]);         
    cbx_rmsEnergy                       = uicheckbox(fig, 'Text','rmsEnergy',                   'Enable', flagAsDescs,  'Position',	[190 50 200 22]);         

    % Harmonic Descriptors
    cbx_harmonicEnergy              = uicheckbox(fig, 'Text','harmonicEnergy',              'Enable', flagHarmDescs, 'Position',  	[360 350 200 22]); 
    cbx_harmonicOddToEvenRatio      = uicheckbox(fig, 'Text','harmonicOddToEvenRatio',      'Enable', flagHarmDescs, 'Position', 	[360 320 200 22]); 
    cbx_harmonicSpectralDeviation   = uicheckbox(fig, 'Text','harmonicSpectralDeviation',   'Enable', flagHarmDescs, 'Position',	[360 290 200 22]); 
    cbx_inharmonicity               = uicheckbox(fig, 'Text','inharmonicity',               'Enable', flagHarmDescs, 'Position',   	[360 260 200 22]); 
    cbx_tristimulusValues           = uicheckbox(fig, 'Text','tristimulusValues',           'Enable', flagHarmDescs, 'Position',  	[360 230 200 22]); 

    % Push button: DONE 
    btn = uibutton(fig, 'push', 'Text', 'Done', ...
           'Position',[420, 20, 100, 22],...
           'ButtonPushedFcn', ...
           @(btn,event) doneDescriptors(src, ...
           cbx_spectralCentroid, cbx_spectralCrest, cbx_spectralDecrease, cbx_spectralFlatness, cbx_spectralFlux, cbx_spectralKurtosis, cbx_spectralRollOff, cbx_spectralSkewness, cbx_spectralSlope, cbx_spectralSpread, cbx_spectralVariation, ...
           cbx_attackSlope, cbx_attackTime, cbx_decreaseSlope, cbx_effectiveDuration, cbx_energyModulation, cbx_temporalCentroid, ...
           cbx_autocorrelationCoefficients, cbx_zeroCrossingRate, cbx_frameEnergy, cbx_rmsEnergy, ...
           cbx_harmonicEnergy, cbx_harmonicOddToEvenRatio, cbx_harmonicSpectralDeviation, cbx_inharmonicity, cbx_tristimulusValues ...
           ));
end

    % --------------- Callback for the ButtonPushedFcn --------------------
    % In total there are 26 descriptors: d1 to d26
    function doneDescriptors( src, ...
            cbx_spectralCentroid, cbx_spectralCrest, cbx_spectralDecrease, cbx_spectralFlatness, cbx_spectralFlux, cbx_spectralKurtosis, cbx_spectralRollOff, cbx_spectralSkewness, cbx_spectralSlope, cbx_spectralSpread, cbx_spectralVariation, ...
            cbx_attackSlope, cbx_attackTime, cbx_decreaseSlope, cbx_effectiveDuration, cbx_energyModulation, cbx_temporalCentroid, ...
            cbx_autocorrelationCoefficients, cbx_zeroCrossingRate, cbx_frameEnergy, cbx_rmsEnergy, ...
            cbx_harmonicEnergy, cbx_harmonicOddToEvenRatio, cbx_harmonicSpectralDeviation, cbx_inharmonicity,cbx_tristimulusValues)

    % --------------------------- Spectral descs -------------------------------

        if cbx_spectralCentroid.Value 
            d1 = 'spectralCentroid';
        else
            d1 = [];
        end

        if cbx_spectralCrest.Value
            d2 = 'spectralCrest';
        else
            d2 = [];
        end

        if cbx_spectralDecrease.Value
            d3 = 'spectralDecrease';
        else
            d3 = [];
        end

        if cbx_spectralFlatness.Value
            d4 = 'spectralFlatness';
        else
            d4 = [];
        end

        if cbx_spectralFlux.Value
            d5 = 'spectralFlux';
        else
            d5 = [];
        end

        if cbx_spectralKurtosis.Value
            d6 = 'spectralKurtosis';
        else
            d6 = [];
        end

        if cbx_spectralRollOff.Value
            d7 = 'spectralRollOff';
        else
            d7 = [];
        end        

        if cbx_spectralSkewness.Value
            d8 = 'spectralSkewness';
        else
            d8 = [];
        end    

        if cbx_spectralSlope.Value
            d9 = 'spectralSlope';
        else
            d9 = [];
        end  

        if cbx_spectralSpread.Value
            d10 = 'spectralSpread';
        else
            d10 = [];
        end

        if cbx_spectralVariation.Value
            d11 = 'spectralVariation';
        else
            d11 = [];
        end

        % --------------------------- TEE descs -------------------------------
        if cbx_attackSlope.Value
            d12 = 'attackSlope';
        else
            d12 = [];
        end

        if cbx_attackTime.Value
            d13 = 'attackTime';
        else
            d13 = [];
        end

        if cbx_decreaseSlope.Value
            d14 = 'decreaseSlope';
        else
            d14 = [];
        end

        if cbx_effectiveDuration.Value
            d15 = 'effectiveDuration';
        else
            d15 = [];
        end    

        if cbx_energyModulation.Value
            d16 = 'energyModulation';
        else
            d16 = [];
        end    

        if cbx_temporalCentroid.Value
            d17 = 'temporalCentroid';
        else
            d17 = [];
        end  

        % ---------------------------- AS descs -------------------------------
        if cbx_autocorrelationCoefficients.Value
            d18 = 'autocorrelationCoefficients';
        else
            d18 = [];
        end    

        if cbx_zeroCrossingRate.Value
            d19 = 'zeroCrossingRate';
        else
            d19 = [];
        end    

        if cbx_frameEnergy.Value
            d20 = 'frameEnergy';
        else
            d20 = [];
        end
        
        if cbx_rmsEnergy.Value
            d21 = 'rmsEnergy';
        else
            d21 = [];
        end
        
        % ---------------------------- HARM descs -----------------------------
        if cbx_harmonicEnergy.Value
            d22 = 'harmonicEnergy';
        else
            d22 = [];
        end 

        if cbx_harmonicOddToEvenRatio.Value
            d23 = 'harmonicOddToEvenRatio';
        else
            d23 = [];
        end 

        if cbx_harmonicSpectralDeviation.Value
            d24 = 'harmonicSpectralDeviation';
        else
            d24 = [];
        end     

        if cbx_inharmonicity.Value
            d25 = 'inharmonicity';
        else
            d25 = [];
        end     

        if cbx_tristimulusValues.Value
            d26 = 'tristimulusValues';
        else
            d26 = [];
        end   
    
        % ------------------------- Get all descs -----------------------------
        src.UserData = {d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17,...
            d18, d19, d20, d21, d22, d23, d24, d25, d26};     % Put all results in a cell array
        close 'Select Audio Descriptors'
    end