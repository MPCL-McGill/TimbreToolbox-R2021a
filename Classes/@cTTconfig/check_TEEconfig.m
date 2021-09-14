function s = check_TEEconfig(userConfig)
%==========================================================================
% Checks the user supplied configurations for TEE representation: 
% TEErep

% INPUT: struct: User supplied Configuration settings used to compute
% TEErep
% OUTPUT: struct: Configuration settings 

% MEMBER OF: cTTconfig.m
%   CALLED BY: get_Reps.m
%       Updates the properties: 
%           Representations.TEErep.config 
%==========================================================================

% Get default configuration
s = cTTconfig.get_default_TEEconfig; 
% acceptedFields = fieldnames(s);
acceptedFields = {'noiseTHD', 'attackTHD', 'decreaseSlopeTHD', 'effectiveDurationTHD'};

% Check noiseTHD
if isfield(userConfig, 'noiseTHD')
    if userConfig.noiseTHD <= 0
        s.noiseTHD = userConfig.noiseTHD;
    else
        error('noiseTHD must be < 0');
    end
end

% Check attackTHD
if isfield(userConfig, 'attackTHD')
    if userConfig.attackTHD <= 0
        s.attackTHD = userConfig.attackTHD;
    else
        error('attackTHD must be <= 0');
    end
end

% Check decreaseSlopeTHD
if isfield(userConfig, 'decreaseSlopeTHD')
    if userConfig.decreaseSlopeTHD <= 0
        s.attackTHD = userConfig.decreaseSlopeTHD;
    else
        error('decreaseSlopeTHD must be <= 0');
    end
end

% Check effectiveDurationTHD
if isfield(userConfig, 'effectiveDurationTHD')
    if userConfig.effectiveDurationTHD <= 0
        s.attackTHD = userConfig.effectiveDurationTHD;
    else
        error('effectiveDurationTHD must be <= 0');
    end
end

% Error if any of the fields is invalid
userFields = fieldnames(userConfig);
for i =1:numel(userFields)
    if ~ismember(userFields{i}, acceptedFields)
        error('Invalid field name: %s', userFields{i})
    end
end