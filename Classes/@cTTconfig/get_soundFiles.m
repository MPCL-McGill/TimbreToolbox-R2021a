function fileList = get_soundFiles(soundsDirectory, whichFile)
%==========================================================================
% Checks if SOUNDSDIRECTORY exists and returns in a cell array the audio 
% files that will be analyzed.

% SOUNDSDIRECTORY: Folder path of audio files to analyze.
% WHICHFILE: char or cell array with user supplied audio files. 
% FILELIST: cell array: List of valid audio files to analyze.

% MEMBER OF: cTTconfig.m
%   Updates the properties: soundFiles   
%==========================================================================

% Only these file formats are accepted from MATLAB's audioread.
% Possible issue when the soundfile has 2 dots before the extension.
% e.g., 'someFile..wav'
acceptedFormats = {'.wav', '.ogg', '.flac', '.au', '.aiff', '.aif', '.aifc', '.mp3', '.m4a', '.mp4'};

% Convert to cell if whichFile ischar and not "ALL": Avoid code replication
if ischar(whichFile) && ~strcmp(whichFile, 'ALL') 
    whichFile = cellstr(whichFile); 
end

% Check if soundsDirectory exists
if isfolder(soundsDirectory) % otherwise exit with error.
    fileList = {}; % File list gets updated with valid sound files.
    
    % 1. If 'ALL' do all files inside soundsDirectory    
    if strcmp(whichFile, 'ALL') % Can also be a struct
        allFiles = dir(soundsDirectory); % allFiles include also INVALID files
        for i = 1:length(allFiles)
            [~, ~, fileExt] = fileparts(allFiles(i).name);
            if ismember(fileExt, acceptedFormats) % Add to fileList  
                fileList = [ fileList; [soundsDirectory '/' allFiles(i).name] ]; 
%             else % Invalid file extension
%                 warning(' ''%s'' will not be analyzed. \n%s',...
%                 allFiles(i).name, '(Unknown or unsupported audio file format)')
            end
        end
 
    % 2. Else: Do only user-specified files
    elseif iscell(whichFile) % Analyze only specified files in the cell array
        for i=1:numel(whichFile) % For all user supplied files
            if isfile([soundsDirectory '/' whichFile{i}]) % If file exists
                % Get the file extension of the file 
                [~, ~, fileExt] = fileparts(whichFile{i});
                % If the extension is valid
                if ismember(fileExt, acceptedFormats) % Add to fileList
                    fileList = [ fileList; [soundsDirectory '/' whichFile{i}] ];  
                else % Invalid file extension
                    warning(' ''%s'' will not be analyzed. \n%s',...
                        whichFile{i}, '(Unknown or unsupported audio file format)')
                end
            else % File not found
                warning(' The audio file ''%s'' was not found.', whichFile{i})               
            end
        end 
        
    end % Which files to analyze
    
else % Folder does not exist
    error('The folder in: %s \n%s' , soundsDirectory, ...
                 'does not exist.')
end

% Final Check - fileList with sounds to analyze is empty
if isempty(fileList)
    error('No valid audio files to analyze in: \n%s %s', soundsDirectory)
end