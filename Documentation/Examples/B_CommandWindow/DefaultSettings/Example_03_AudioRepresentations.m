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
% 4. Specify which audio representations to compute.

% ***************************  Note *************************************** 
% To list all the available representations type in the Command Window: 
AudioRepresentations
% (Comment/Uncomment the above line if you want (or don't want) to list the
% available audio representations.)
% *************************** End of Note *********************************

% Choose the represenation by commenting/uncommenting one of the following: 

% 4a. -------------- Select a single audio representation -----------------
% Reps = {'PowSTFTrep'};    % Do only the PowSTFTrep
% Reps = {'MagSTFTrep'};    % Do only the MagSTFTrep
% Reps = {'ERBrep'};        % Do only the ERBrep
Reps = {'HARMrep'};         % Do only the HARMrep
% Reps = {'ASrep'};         % Do only the ASrep
% Reps = {'TEErep'};        % Do only the TEErep

% 4b. -------------- Compute multiple audio representations ----------------
% >>>>> Not recommended (unless you have sufficient RAM) <<<<<<<<<<<<<<<<<<
% Reps = {'PowSTFTrep', 'HARMrep'}; % Compute both the PowSTFTrep and HARMrep

% 4c. -------------- Compute all audio representations ---------------------
% >>>>> Not recommended (unless you have sufficient RAM ) <<<<<<<<<<<<<<<<<
% Reps = 'ALL'; % Compute all representations



% =========================================================================
% 5. Analyze the audio files. 
TT_descriptors(soundsDirectory, resultsDirectory, Files, Reps);


% =========================================================================
% 6. Export the summary statisitcs to .csv files 
sumStats_to_csv(resultsDirectory);