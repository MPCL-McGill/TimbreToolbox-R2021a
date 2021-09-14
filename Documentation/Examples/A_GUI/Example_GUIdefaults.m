%==========================================================================
%  Runs the Timbre Toolbox's GUI for default Representation Settings. 

% It is assumed that:

% 1. TimbreToolbox-R2021a folder is in MATLAB's path. To do so right-click
% 'TimbreToolbox-R2021a' folder and select 
% 'Add to Path' < 'Selected Folders and Subfolders'.

% 2. The folder containing the audio files (in this case
% 'SoundsToAnalyze') 
% and 
% 3. the folder to store the analysis results (in this case 'Results') 
% both exist.

% Press 'Run' in MATLAB's EDITOR (select "Add to Path" in MATLAB's prompt)
% or 
% 'command' and 'return' on your keyboard 
% to run this example.

% The analysis results will be stored in the 'Results' folder.
%==========================================================================

clearvars; close all; clc;

% 1. Open the GUI.
TT_GUIdefaults

% 2. Select which audio files to analyze by clicking on "Audio Files".

% 3. Select the folder in which the analysis results will be stored by clicking on
% "Results Folder".

% 4. Select at least one audio representation by clicking on "Audio
% Representations". 
% *** It's not recommended to use more than one 
% audio representation at a time, due to high memory consumption. ***

% 5. Select which audio descriptors to compute by clicking on "Audio
% Descriptors". 
% *** Only the descriptors relevant to the chosen Audio Representations will be
% available. ***

% 6. Select which summary statistics to compute by clicking on "Summary
% Statistics". 

% 7. Tick the option "Export Summary Statistics to .csv format" if you want
% to export the summary statistics (.mat) as .csv files. 

% 8. Click on "Analyze" to analyze your audio files.
% *** The GUI window will be closed. Inspect the Command Window for any
% errors and warnings. ***