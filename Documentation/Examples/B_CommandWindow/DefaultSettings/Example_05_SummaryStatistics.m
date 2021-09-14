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
Files = 'ALL';          % Analyze all audio files   


% =========================================================================
% 4. Specify which audio representations to compute.
Reps = {'HARMrep'};     % Do only the HARMrep


% =========================================================================
% 5. Specify which audio descriptors to compute.
Descs = 'ALL';          % Compute all audio descriptors


% =========================================================================
% 6. Specify which summary statistics to compute.

% ***************************  Note *************************************** 
% To see all the available statistics type in the Command Window: 
SummaryStatistics               
% (Comment/Uncomment the above line if you want (or don't want) to list the
% available statistics.)

Stats = {'IQR', 'Median'};      % Compute only the IQR and the Median
% Stats = {'Median'};           % Compute only the median (default)


% =========================================================================
% 7. Analyze the audio files. 
TT_descriptors(soundsDirectory, resultsDirectory, Files, Reps, Descs, Stats);

% =========================================================================
% 8. Export the summary statisitcs to .csv files 
sumStats_to_csv(resultsDirectory);