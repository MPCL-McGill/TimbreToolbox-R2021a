function get_UIdefaults(itAudioFiles, itResultsFolder,...
    itTEErep, itPowSTFTrep, itMagSTFTrep, itHARMrep, itERBrep, itASrep,...
    itAllDescs, itSelDescs,...
    itMedian, itIQR, itMean, itStd, itMin, itMax, cbx_SumStats2csv)
% Gets all the data from the GUI and calls TT_descriptors.m

if ~isempty(itAudioFiles.UserData)
    soundsDirectory         = itAudioFiles.UserData{1,1};
    soundsDirectory(end)    = []; % Remove the last '/'.
    Files                   = itAudioFiles.UserData{2, 1}; 
else
    close 'Timbre Toolbox'
    error('Select a list of ''Audio Files'' to analyze.')
end

if ~isempty(itResultsFolder.UserData)
    resultsDirectory        = itResultsFolder.UserData;
else
    close 'Timbre Toolbox'
    error('Select your ''Results Folder''. ')
end


Reps                    = {itTEErep.UserData, itPowSTFTrep.UserData, itMagSTFTrep.UserData, itHARMrep.UserData, itERBrep.UserData, itASrep.UserData};
Reps                    = Reps(~cellfun('isempty',Reps));
if numel(Reps) == 0
    close 'Timbre Toolbox'
    error('Select at least one Audio Representation. ')
end


if ~isempty(itAllDescs.UserData)
    Descs               = itAllDescs.UserData;
elseif iscell(itSelDescs.UserData) 
    Descs               = itSelDescs.UserData;
    Descs               = Descs(~cellfun('isempty',Descs));
    if numel(Descs) == 0
        close 'Timbre Toolbox'
        error('Select at least one Audio Descriptor. ')   
    end
else
    close 'Timbre Toolbox'
   	error('Select at least one Audio Descriptor. ') 
end


Stats                   = {itMedian.UserData, itIQR.UserData, itMean.UserData, itStd.UserData, itMin.UserData, itMax.UserData};
Stats                   = Stats(~cellfun('isempty',Stats));
if numel(Stats) == 0
    close 'Timbre Toolbox'
    error('Select at least one Summary Statistic. ')
end


if cbx_SumStats2csv.Value 
    flagCSVstats = 1;
else
    flagCSVstats = 0;
end

clearvars -except soundsDirectory resultsDirectory Files Reps Descs Stats flagCSVstats
close 'Timbre Toolbox'

% Call the main function to compute audio descriptors.
TT_descriptors(soundsDirectory, resultsDirectory, Files, Reps, Descs, Stats);

if flagCSVstats
    sumStats_to_csv(resultsDirectory);
end

end