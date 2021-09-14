function [timeSeries, summaryStatistics] = do_PowSTFTrep...
    (TTconfig_o, filename, waveform, fs, rep, summaryStatistics)
%==========================================================================
% Computes the PowSTFTrep.
% Returns the time-series and summary statistics of descriptor values.
% *** The only difference with do_MagSTFTrep.m is in line 28 in which the
% power spectrum is computed. ***

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
 % % ********** Power spectrum **************
 STFTrep_o.RepValues = (STFTrep_o.RepValues).^2;

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