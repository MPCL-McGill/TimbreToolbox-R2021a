function get_UIsettings(itAudioFiles, itResultsFolder,...
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

% ===================== Representation Settings ===========================

if isstruct(itERBrep.UserData)
    Reps.ERBrep.fLow                = itERBrep.UserData.fLow;
    Reps.ERBrep.nChannels           = itERBrep.UserData.nChannels;
    if (itERBrep.UserData.winLength > 0) && (itERBrep.UserData.hopSize > 0)
        Reps.ERBrep.winLength      	= itERBrep.UserData.winLength;
        Reps.ERBrep.hopSize        	= itERBrep.UserData.hopSize;
    else
        Reps.ERBrep.winLength_s  	= itERBrep.UserData.winLength_s;
        Reps.ERBrep.hopSize_s     	= itERBrep.UserData.hopSize_s;
    end
end

if isstruct(itHARMrep.UserData)
    Reps.HARMrep.magnitudeThreshold   	= itHARMrep.UserData.magnitudeThreshold;
    Reps.HARMrep.minPartialsDuration 	= itHARMrep.UserData.minPartialsDuration;
    Reps.HARMrep.inharmonicityTolerance	= itHARMrep.UserData.inharmonicityTolerance;
    Reps.HARMrep.pitchRange             = [itHARMrep.UserData.minPitch,  itHARMrep.UserData.maxPitch];
    Reps.HARMrep.winType                = itHARMrep.UserData.winType;
    if (itHARMrep.UserData.winLength > 0) && (itHARMrep.UserData.hopSize > 0)
        Reps.HARMrep.winLength       	= itHARMrep.UserData.winLength;
        Reps.HARMrep.hopSize        	= itHARMrep.UserData.hopSize;
    else
        Reps.HARMrep.winLength_s        = itHARMrep.UserData.winLength_s;
        Reps.HARMrep.hopSize_s          = itHARMrep.UserData.hopSize_s;
    end
end

if isstruct(itMagSTFTrep.UserData)
    Reps.MagSTFTrep.winType             = itMagSTFTrep.UserData.winType;
    if (itMagSTFTrep.UserData.winLength > 0) && (itMagSTFTrep.UserData.hopSize > 0)
        Reps.MagSTFTrep.winLength     	= itMagSTFTrep.UserData.winLength;
        Reps.MagSTFTrep.hopSize        	= itMagSTFTrep.UserData.hopSize;
    else
        Reps.MagSTFTrep.winLength_s  	= itMagSTFTrep.UserData.winLength_s;
        Reps.MagSTFTrep.hopSize_s     	= itMagSTFTrep.UserData.hopSize_s;
    end
end

if isstruct(itPowSTFTrep.UserData)
    Reps.PowSTFTrep.winType             = itPowSTFTrep.UserData.winType;
    if (itPowSTFTrep.UserData.winLength > 0) && (itPowSTFTrep.UserData.hopSize > 0)
        Reps.PowSTFTrep.winLength     	= itPowSTFTrep.UserData.winLength;
        Reps.PowSTFTrep.hopSize        	= itPowSTFTrep.UserData.hopSize;
    else
        Reps.PowSTFTrep.winLength_s  	= itPowSTFTrep.UserData.winLength_s;
        Reps.PowSTFTrep.hopSize_s     	= itPowSTFTrep.UserData.hopSize_s;
    end
end

if isstruct(itTEErep.UserData)
    Reps.TEErep.noiseTHD                = itTEErep.UserData.noiseTHD;
    Reps.TEErep.attackTHD               = itTEErep.UserData.attackTHD;
    Reps.TEErep.decreaseSlopeTHD        = itTEErep.UserData.decreaseSlopeTHD;
    Reps.TEErep.effectiveDurationTHD    = itTEErep.UserData.effectiveDurationTHD;
end

if isstruct(itASrep.UserData)
    if (itASrep.UserData.winLength > 0) && (itASrep.UserData.hopSize > 0)
        Reps.ASrep.winLength     	= itASrep.UserData.winLength;
        Reps.ASrep.hopSize        	= itASrep.UserData.hopSize;
    else
        Reps.ASrep.winLength_s  	= itASrep.UserData.winLength_s;
        Reps.ASrep.hopSize_s     	= itASrep.UserData.hopSize_s;
    end    
end

if isempty(itTEErep.UserData) && isempty(itPowSTFTrep.UserData) && isempty(itMagSTFTrep.UserData) && isempty(itHARMrep.UserData) && isempty(itERBrep.UserData) && isempty(itASrep.UserData)
    close 'Timbre Toolbox'
	error('Select at least one Audio Representation. ')
end

% Reps                    = {itTEErep.UserData, itPowSTFTrep.UserData, itMagSTFTrep.UserData, itHARMrep.UserData, itERBrep.UserData, itASrep.UserData};
% Reps                    = Reps(~cellfun('isempty',Reps));
% if numel(Reps) == 0
%     close 'Timbre Toolbox'
%     error('Select at least one Audio Representation. ')
% end
% ================ End of Representation Settings =========================

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