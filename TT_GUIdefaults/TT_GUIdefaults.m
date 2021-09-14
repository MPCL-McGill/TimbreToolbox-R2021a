function  TT_GUIdefaults
% Gui that uses the default representation settings.

% ---------------------- MENU ELEMENTS ------------------------------------
fig     = uifigure('Name','Timbre Toolbox','HandleVisibility', 'on'); % Now you can use close all;

% Labels:
lbl1 = uilabel(fig);
lbl1.Text = 'The results will be saved in the specified ''Results Folder''.';
lbl1.Position = [20 180 400 22];

lbl2 = uilabel(fig);
lbl2.Text = 'The progression of the analysis will be displayed in the Command Window.';
lbl2.Position = [20 160 450 22];

lbl3 = uilabel(fig);
lbl3.Text = 'Any errors and warnings will be displayed in the Command Window.';
lbl3.Position = [20 140 400 22];

% Menu basic elements
mAudioFiles         = uimenu (fig, 'Text', 'Audio Files');
mResultsFolder      = uimenu (fig, 'Text', '    Results Folder');
mAudioReps          = uimenu (fig, 'Text', '    Audio Representations');
mAudioDescs         = uimenu (fig, 'Text', '    Audio Descriptors');
mSumStats           = uimenu (fig, 'Text', '    Summary Statistics');


% ---------------------------ITEMS ----------------------------------------
itAudioFiles        = uimenu(mAudioFiles,      'Text', '&Select...');     % Audio files
itResultsFolder     = uimenu(mResultsFolder,   'Text', '&Select...');     % Results Folder

itTEErep            = uimenu(mAudioReps,       'Text','TEErep','Checked','off');
itPowSTFTrep        = uimenu(mAudioReps,       'Text','PowSTFTrep','Checked','on');
itMagSTFTrep        = uimenu(mAudioReps,       'Text','MagSTFTrep','Checked','off');
itHARMrep           = uimenu(mAudioReps,       'Text','HARMrep','Checked','off');
itERBrep            = uimenu(mAudioReps,       'Text','ERBrep','Checked','off');
itASrep             = uimenu(mAudioReps,       'Text','ASrep','Checked','off');

itAllDescs          = uimenu(mAudioDescs,      'Text','ALL','Checked','on');  
itSelDescs          = uimenu(mAudioDescs,      'Text','&Select...'); 

itMedian            = uimenu(mSumStats,        'Text','Median','Checked','on');
itIQR               = uimenu(mSumStats,        'Text','IQR','Checked','off');
itMean              = uimenu(mSumStats,        'Text','Mean','Checked','off');
itStd               = uimenu(mSumStats,        'Text','Std','Checked','off');
itMin               = uimenu(mSumStats,        'Text','Min','Checked','off');
itMax               = uimenu(mSumStats,        'Text','Max','Checked','off');


% Check box: EXPORT SUMMARY STATS TO .CSV
cbx_SumStats2csv    = uicheckbox(fig, 'Text','Export Summary Statistics to .csv format', 'Position', [20 230 300 22]);

% push button: QUIT
btnQuit = uibutton(fig,'push', 'Text', 'Quit', ...
               'Position',[20, 20, 100, 22],...
               'ButtonPushedFcn', @(btnQuit,event) quitUI(btnQuit));

% push button: ANALYZE ----> Final Function: get_UIdata.m
btnAnalyze = uibutton(fig,'push', 'Text', 'Analyze', ...
               'Position',[420, 20, 100, 22],...
               'ButtonPushedFcn', @(btnAnalyze,event) get_UIdefaults(...,
               itAudioFiles, itResultsFolder,...
               itTEErep, itPowSTFTrep, itMagSTFTrep, itHARMrep, itERBrep, itASrep,...
               itAllDescs, itSelDescs, ...
               itMedian, itIQR, itMean, itStd, itMin, itMax, cbx_SumStats2csv));


% ------------------------ Default Values ---------------------------------
itPowSTFTrep.UserData   = 'PowSTFTrep';
itMedian.UserData       = 'Median';
itAllDescs.UserData     = 'ALL';

% ------------------------ Assign callback functions ----------------------
itAudioFiles.MenuSelectedFcn        = @AudioFiles;
itResultsFolder.MenuSelectedFcn     = @ResultsFolder;

% Audio representations
itTEErep.MenuSelectedFcn        = @TEErep;
itPowSTFTrep.MenuSelectedFcn    = @PowSTFTrep;
itMagSTFTrep.MenuSelectedFcn    = @MagSTFTrep;
itHARMrep.MenuSelectedFcn       = @HARMrep;
itERBrep.MenuSelectedFcn        = @ERBrep;
itASrep.MenuSelectedFcn         = @ASrep;

% Audio descriptors
itAllDescs.MenuSelectedFcn      = @AllDescs;
itSelDescs.MenuSelectedFcn      = {@SelDescs, itAllDescs, itTEErep, itPowSTFTrep, itMagSTFTrep, itHARMrep, itERBrep, itASrep};

% Summary Stats
itMedian.MenuSelectedFcn    = @medianStats;
itIQR.MenuSelectedFcn       = @iqrStats;
itMean.MenuSelectedFcn      = @meanStats;
itStd.MenuSelectedFcn      	= @stdStats;
itMin.MenuSelectedFcn     	= @minStats;
itMax.MenuSelectedFcn    	= @maxStats;

end