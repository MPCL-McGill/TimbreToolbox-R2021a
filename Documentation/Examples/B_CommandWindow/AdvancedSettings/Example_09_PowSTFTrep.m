%==========================================================================
% Provides examples on how to run the Timbre Toolbox.

% It is assumed that:

% 1. TimbreToolbox-R2021a folder is in MATLAB's path. To do so, right-click
% 'TimbreToolbox-R2021a' folder and select 
% 'Add to Path' > 'Selected Folders and Subfolders'.

% 2. The folder containing the audio files (in this case
% 'SoundsToAnalyze') 
% and 
% 3. the folder to store the analysis results (in this case 'Results') 
% both exist.

% Press 'Run' in MATLAB's EDITOR 
% or 
% 'command' and 'return' on your keyboard 
% to run this example.

% The analysis results will be stored in the 'Results' folder.
%==========================================================================
clearvars; clc; close all;

% 1. Specify the folder path of audio files.
soundsDirectory = [pwd '/TimbreToolbox-R2021a/Documentation/SoundsToAnalyze'];

% =========================================================================
% 2. Specify the folder path in which the results will be stored.
resultsDirectory = [pwd '/TimbreToolbox-R2021a/Documentation/Results'];

% =========================================================================
% 3. Specify which audio files to analyze (must be located insided
% the 'soundsDirectory' folder path).
Files = 'ALL';  % Analyze all audio files   

% =========================================================================
% 4. Change one or more settings of the PowSTFTrep.  
Reps.PowSTFTrep.winType         = 'hann';       % Window type
Reps.PowSTFTrep.winLength_s     = 0.04645;      % Window length - in seconds
Reps.PowSTFTrep.hopSize_s       = 0.04645/4;  	% Hop size - in seconds
% Reps.PowSTFTrep.winLength     = 2048;         % Window length - in samples
% Reps.PowSTFTrep.hopSize       = 512;          % Hop size - in samples


% =========================================================================
% 6. Specify which audio descriptors to compute.
Descs = 'ALL';              % Do all audio descriptors. 

% =========================================================================
% 7. Specify which summary statistics to compute.
Stats = 'ALL';              % Do all summary statistics.

% =========================================================================
% 7. Analyze the audio files. 
TT_descriptors(soundsDirectory, resultsDirectory, Files, Reps, Descs, Stats);

% =========================================================================
% 6. Export the summary statisitcs to .csv files (uncomment the following
% line).
% sumStats_to_csv(resultsDirectory);