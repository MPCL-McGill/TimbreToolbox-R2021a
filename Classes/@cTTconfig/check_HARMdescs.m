function s = check_HARMdescs(userConfig)
%==========================================================================
% Removes descriptors to compute if not supplied by user. 

% INPUT: cell or char: User supplied Descriptors for Harmonic representation: 
% HARMrep 
% OUTPUT: struct: Audio Descriptors that will be evaluated.

% MEMBER OF: cTTconfig.m
%   CALLED BY: get_Descs.m
%==========================================================================

% Get all descriptors
s = cTTconfig.get_default_HARMdescs; 

allDescs = fieldnames(s); % All descs of this representation
for i = 1:numel(allDescs)
    if ~ismember(allDescs{i}, userConfig)
        s = rmfield(s, allDescs(i));
    end
end
