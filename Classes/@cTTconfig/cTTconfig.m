classdef cTTconfig
%==========================================================================
% INPUT: User supplied arguments
% OUTPUT: An object with verified user-supplied arguments.
% Returns the configuration settings for each representation.

% REPRESENTATIONS: Which representations to compute and configuration settings.
% SUMMARYSTATISTICS: Which summary statistics to compute.
% SOUNDFILES: A list of sound files to process. 

% CALLED BY: TT_descriptors.m
%==========================================================================
    properties
        Representations
        SummaryStatistics
        soundFiles
    end
    
    methods (Static) % Validate user input (s: struct, c: cell array)
        
        % ================== Representations ==============================
        s = get_Reps(userReps); % User supplied representations
        
        % ================== Configuration ================================
        % STFT representation (STFTrep)
        s = get_default_STFTconfig; % Default configurations
        s = check_STFTconfig(userConfig); % User's struct configuration
        % Harmonic representation (HARMrep)
        s = get_default_HARMconfig; % Default configurations
        s = check_HARMconfig(userConfig); % User's struct configuration        
        % Temporal Energy Envelope (TEErep)
        s = get_default_TEEconfig; % Default configurations
        s = check_TEEconfig(userConfig); % User's struct configuration
        % Audio Signal (ASrep)
        s = get_default_ASconfig; % Default configurations
        s = check_ASconfig(userConfig); % User's struct configuration 
        % ERB representation (ERBrep)
        s = get_default_ERBconfig; % Default configurations
        s = check_ERBconfig(userConfig); % User's struct configuration
        
        % ====================== Descriptors ==============================
        s = get_Descs(validReps, userDescs); % User supplied descriptors
        s = get_invalidDescs(userConfig); % Warn user for invalid descriptors
        % Descriptors for the STFTrep
        s = get_default_STFTdescs; % All descs of the STFT representation
        s = check_STFTdescs(userConfig); % Compute only (valid) user supplied descriptors
        % Descriptors for the HARMrep
        s = get_default_HARMdescs; % All descs of the HARM representation
        s = check_HARMdescs(userConfig); % Compute only (valid) user supplied descriptors
        % Descriptors for the TEErep
        s = get_default_TEEdescs; % All descs of the HARM representation
        s = check_TEEdescs(userConfig); % Compute only (valid) user supplied descriptors
       % Descriptors for the ASrep
        s = get_default_ASdescs; % All descs of the HARM representation
        s = check_ASdescs(userConfig); % Compute only (valid) user supplied descriptors
       % Descriptors for the ERBrep
        s = get_default_ERBdescs; % All descs of the HARM representation
        s = check_ERBdescs(userConfig); % Compute only (valid) user supplied descriptors
                   
        % =================== Files to analyze ============================
        c = get_soundFiles(soundsDirectory, userFiles);
        
        % ==== Summary Statistics (include option for TimeSeries) =========
        c = get_Stats(userStats) 
        
        % =============== Generate Results Sub-Folders ====================
        [] = gen_resultsSubfolders(resultsDirectory, representations)
    end
   
    methods % Constructor 
        function obj = cTTconfig(soundsDirectory, resultsDirectory, ...
                userFiles, userReps, userDescs, userStats)
            % Validated representations and configurations
            obj.Representations = cTTconfig.get_Reps(userReps);
            
            % Validated Descriptors 
            allDescs = cTTconfig.get_Descs(fieldnames(obj.Representations), userDescs);
            
            % Update descriptor fields only for reps in obj.Representations
            if isfield(obj.Representations, 'PowSTFTrep')
                obj.Representations.PowSTFTrep.descs = allDescs.descsPowSTFT;
            end
            if isfield(obj.Representations, 'MagSTFTrep')
                obj.Representations.MagSTFTrep.descs = allDescs.descsMagSTFT;
            end
            if isfield(obj.Representations, 'HARMrep')
                obj.Representations.HARMrep.descs = allDescs.descsHARM;
            end
            if isfield(obj.Representations, 'TEErep')
                obj.Representations.TEErep.descs = allDescs.descsTEE;
            end
            if isfield(obj.Representations, 'ASrep')
                obj.Representations.ASrep.descs = allDescs.descsAS;
            end
            if isfield(obj.Representations, 'ERBrep')
                obj.Representations.ERBrep.descs = allDescs.descsERB;
            end
%+++++++++++++++++++++++ ADD REPRESENTATIONS ++++++++++++++++++++++++++++++
            
            % Validated soundFiles
            obj.soundFiles = cTTconfig.get_soundFiles(soundsDirectory, userFiles);
            
            % Summary Statistics
            obj.SummaryStatistics = cTTconfig.get_Stats(userStats);
            
            % Check if Results folder exist / Generate Results Sub-Folders
            cTTconfig.gen_resultsSubfolders(resultsDirectory, fieldnames(obj.Representations));
        end
    end 
end