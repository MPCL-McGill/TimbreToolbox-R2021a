function [timeSeries, summaryStatistics] = do_TEErep...
    (TTconfig_o, filename, waveform, fs, rep, summaryStatistics)
%==========================================================================
% Computes the TEErep and returns the descriptor values.

% TTCONFIG_O: The configuration object
% FILENAME: Name of the sound file.
% WAVEFORM, FS: The waveform and sampling rate 
% REP: Which representation to compute
% 
% TIMESERIES: Table of time-series
% SUMMARYSTATISTICS: (Concatenated) Table of summary statistics

% CALLED BY: TT_descriptors.m
%==========================================================================

 % Get fields from configuration object (TTconfig_o)
 config = TTconfig_o.Representations.(rep).config;
 descs = fieldnames(TTconfig_o.Representations.(rep).descs);
 stats = TTconfig_o.SummaryStatistics;

 % Instantiate the object
 TEErep_o = cTEErep(waveform, fs, config, descs);

 % Calculate descriptors from superclass methods
 for j=1:numel(descs)
     TEErep_o = TEErep_o.(descs{j});
 end

% Convert Representation Object to Struct 
repResults.(filename).(rep) = teeObj_to_struct(TEErep_o);
clear TEErep_o

% Time-series of descriptor values inside a Table
timeSeries = struct2table( repResults.(filename).(rep) ); 

% No summary statistics in TEErep - Put these descriptors in 'Value' field
Tfilename = table();
Tfilename.SoundFile = cellstr(filename);
newTableEntry = [Tfilename, timeSeries];
summaryStatistics.(rep).Value = [summaryStatistics.(rep).Value; newTableEntry];