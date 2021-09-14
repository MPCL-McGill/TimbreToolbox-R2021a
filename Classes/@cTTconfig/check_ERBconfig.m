function s = check_ERBconfig(userConfig)
%==========================================================================
% Checks the user supplied configurations for the ERB representation: 
% ERBrep

% INPUT: struct: User supplied Configuration settings used to compute the
% ERBrep
% OUTPUT: struct: Configuration settings 

% MEMBER OF: cTTconfig.m
%   CALLED BY: get_Reps.m
%       Updates the properties: 
%           Representations.ERBrep.config 
%==========================================================================

% Get default configuration
s = cTTconfig.get_default_ERBconfig; 
acceptedFields = {'winLength_s', 'winLength', 'hopSize_s', 'hopSize', 'fLow', 'nChannels'};


% Check fLow
if isfield(userConfig, 'fLow')
    if (userConfig.fLow > 0) 
        s.fLow = userConfig.fLow;
    else
        error('fLow must be greater than zero.');
    end
end

% Check nChannels
if isfield(userConfig, 'nChannels')
    if (userConfig.nChannels > 0) 
        s.nChannels = userConfig.nChannels;
    else
        error('nChannels must be greater than zero.');
    end
end


% Check if winLength is in samples or in seconds
if all(isfield(userConfig,{'winLength', 'winLength_s'}))
    error ('''winLength''cannot be specified both in samples and in seconds')
elseif isfield(userConfig, 'winLength')     % Remove winLength_s - Default
    s.winLength = userConfig.winLength;
    s = rmfield(s, 'winLength_s');
elseif isfield(userConfig, 'winLength_s') 
    s.winLength_s = userConfig.winLength_s;
end

% Check if hopSize is in samples or in seconds
if all(isfield(userConfig,{'hopSize', 'hopSize_s'}))
    error ('''hopSize''cannot be specified both in samples and in seconds')
elseif isfield(userConfig, 'hopSize')       % Remove hopSize_s - Default
    s.hopSize = userConfig.hopSize;
    s = rmfield(s, 'hopSize_s');
elseif isfield(userConfig, 'hopSize_s') 
    s.hopSize_s = userConfig.hopSize_s;
end

% Check the final structure (s) for inconsistencies - samples vs ms:
if all(isfield(s,{'winLength', 'hopSize_s'}))
    error('''winLength'' and ''hopsize_s'' (default) units do not agree.')
end
if all(isfield(s,{'winLength_s', 'hopSize'}))
    error('''winLength_s'' (default) and ''hopsize'' units do not agree.')
end

% Error if any of the fields is invalid
userFields = fieldnames(userConfig);
for i =1:numel(userFields)
    if ~ismember(userFields{i}, acceptedFields)
        error('Invalid field name: %s', userFields{i})
    end
end