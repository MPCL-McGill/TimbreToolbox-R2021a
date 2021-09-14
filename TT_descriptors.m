function [] = TT_descriptors(soundsDirectory, resultsDirectory, ...
    userFiles, userReps, userDescs, userStats)
%==========================================================================
% Main function called by user to calculate descriptors. 
% Saves the time-series and summary statistics of descriptor values in 
% Table arrays.

% SOUNDSDIRECTORY:  Folder path of audio files to analyze.
% RESULTSDIRECTORY: Folder path to store the results.
% USERFILES:        User supplied audio files to analyze.
% USERREPS:         User supplied audio representations and configuration settings.
% USERDESCS:        User supplied audio descriptors to compute.
% USERSTATS:        User supplied summary statistics to compute.
%==========================================================================
if nargin < 6
    userStats = 'Median';
end

if nargin < 5
    userDescs = 'ALL';
end

if nargin < 4
    userReps = 'PowSTFTrep';
end

if nargin < 3
    userFiles = 'ALL';
end

dispVersion; % Display the version

% Configuration object
TTconfig_o = cTTconfig(soundsDirectory, resultsDirectory, ...
    userFiles, userReps, userDescs, userStats);

%>>>>>>>>>>> Initialize summaryStatistics - struct with Tables <<<<<<<<<<<<
allReps = fieldnames(TTconfig_o.Representations);
allStats = TTconfig_o.SummaryStatistics;
for i = 1:numel(allReps)
    for j=1:numel(allStats)
        % Dynamic Field Naming - summary stats inside a table
        summaryStatistics.(allReps{i}).(allStats{j}) = table(); 
    end
    if strcmp(allReps{i}, 'TEErep')
        % Generate a new field 'Value' (no summary statistics in TEErep)
        summaryStatistics.(allReps{i}).Value = table(); 
    end
end
clear allReps allStats

%>>>>>>>>>>>>>>>>> Audio Descriptor Calculation <<<<<<<<<<<<<<<<<<<<<<<<<<<
for i=1:numel(TTconfig_o.soundFiles)
    fprintf ('Processing %d of %d audio files.\n', i, numel(TTconfig_o.soundFiles))
    
    [waveform, fs] = audioread(TTconfig_o.soundFiles{i}); 
    [~,filename,~] = fileparts(TTconfig_o.soundFiles{i});
    
    % ----------------- preprocess_audioFile ------------------------------
    waveform = preprocess_audioFile(waveform);
    
    
    % ----------------- Do the Representations ----------------------------
    rep = 'PowSTFTrep'; % Use dynamic field naming.
    if isfield(TTconfig_o.Representations, rep)
    [timeSeries, summaryStatistics] = do_PowSTFTrep ...
        (TTconfig_o, filename, waveform, fs, rep, summaryStatistics);
    save([resultsDirectory, '/TimeSeries/', rep, '/', filename, '.mat'], 'timeSeries');
    clear timeSeries
    end 
    
    
    
    rep = 'MagSTFTrep'; % Use dynamic field naming.
    if isfield(TTconfig_o.Representations, rep)
    [timeSeries, summaryStatistics] = do_MagSTFTrep ...
        (TTconfig_o, filename, waveform, fs, rep, summaryStatistics);
    save([resultsDirectory, '/TimeSeries/', rep, '/', filename, '.mat'], 'timeSeries');
    clear timeSeries
    end 

    
    
    rep = 'HARMrep'; % Use dynamic field naming.
    if isfield(TTconfig_o.Representations, rep)
    [timeSeries, summaryStatistics] = do_HARMrep ...
        (TTconfig_o, filename, waveform, fs, rep, summaryStatistics);
    save([resultsDirectory, '/TimeSeries/', rep, '/', filename, '.mat'], 'timeSeries');
    clear timeSeries
    end 
    
    
    
    rep = 'TEErep'; % Use dynamic field naming.
    if isfield(TTconfig_o.Representations, rep)
    [timeSeries, summaryStatistics] = do_TEErep ...
        (TTconfig_o, filename, waveform, fs, rep, summaryStatistics);
    % +++++++++++++++++ Special Case: No summary stats here +++++++++++++++
    % Clear fields of summaryStatistics except the 'Value' field.
    statFields = fieldnames(summaryStatistics.TEErep); 
        for j=1:numel(statFields)
            if ~strcmp(statFields{j}, 'Value')
                summaryStatistics.TEErep = rmfield(summaryStatistics.TEErep, statFields(j));
            end
        end
    save([resultsDirectory, '/TimeSeries/', rep, '/', filename, '.mat'], 'timeSeries');
    clear timeSeries
    end
    
    
    
    rep = 'ASrep'; % Use dynamic field naming.
    if isfield(TTconfig_o.Representations, rep)
    [timeSeries, summaryStatistics] = do_ASrep ...
        (TTconfig_o, filename, waveform, fs, rep, summaryStatistics);
    save([resultsDirectory, '/TimeSeries/', rep, '/', filename, '.mat'], 'timeSeries');
    clear timeSeries
    end
    
    
    
    rep = 'ERBrep'; % Use dynamic field naming.
    if isfield(TTconfig_o.Representations, rep)
    [timeSeries, summaryStatistics] = do_ERBrep ...
        (TTconfig_o, filename, waveform, fs, rep, summaryStatistics);
    save([resultsDirectory, '/TimeSeries/', rep, '/', filename, '.mat'], 'timeSeries');
    clear timeSeries
    end
%+++++++++++++++++++++++ ADD REPRESENTATIONS ++++++++++++++++++++++++++++++

end 

% Save all the summary statistics
save([resultsDirectory, '/summaryStatistics.mat'], 'summaryStatistics');