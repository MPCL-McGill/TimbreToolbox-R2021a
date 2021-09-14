function [timeSeries, summaryStatistics] = do_MagSTFTrep...
    (TTconfig_o, filename, waveform, fs, rep, summaryStatistics)
%==========================================================================
% Computes the MagSTFTrep.
% Returns the time-series and summary statistics of descriptor values.

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
 STFTrep_o = cSTFTrep(waveform, fs, config, descs);

 % Calculate descriptors from superclass methods
 for j=1:numel(descs)
     STFTrep_o = STFTrep_o.(descs{j});
 end

% Convert Representation Object to Struct 
repResults.(filename).(rep) = stftObj_to_struct(STFTrep_o);
clear STFTrep_o

% Time-series of descriptor values inside a Table
timeSeries = struct2table( repResults.(filename).(rep) ); 

% Get the summary statistics
for k = 1:numel(stats)
    newTableEntry = do_summaryStats(timeSeries, filename, stats{k});
    % previousEntries = summaryStats.(rep).(stats{k});
    summaryStatistics.(rep).(stats{k}) = ...
        [summaryStatistics.(rep).(stats{k}); newTableEntry];
end