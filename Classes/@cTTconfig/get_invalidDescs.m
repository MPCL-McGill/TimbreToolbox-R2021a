function get_invalidDescs(userConfig)
%==========================================================================
% Outputs a warning for invalid descriptors. 
% INPUT: cell or char: User supplied descriptors
% OUTPUT: WARNING if user supplied invalid descriptors for a given
% representation.

% CALLED BY: get_Descs.m
%==========================================================================

% Get descriptors from all Reps
s_STFT  = cTTconfig.get_default_STFTdescs; 
s_HARM  = cTTconfig.get_default_HARMdescs; 
s_TEE   = cTTconfig.get_default_TEEdescs; 
s_AS    = cTTconfig.get_default_ASdescs; 
s_ERB   = cTTconfig.get_default_ERBdescs; 
%+++++++++++++++++++++++ ADD REPRESENTATIONS ++++++++++++++++++++++++++++++

allDescs = [ 
    fieldnames(s_STFT); fieldnames(s_HARM); fieldnames(s_TEE); fieldnames(s_AS); fieldnames(s_ERB);
    ]; % Concatenate vertically
%+++++++++++++++++++++++ ADD REPRESENTATIONS ++++++++++++++++++++++++++++++

for i=1:numel(userConfig) % All user supplied descs 
    if ~ismember(userConfig{i}, allDescs) % If is not a valid descriptor 
        warning ('Unknown descriptor: %s', userConfig{i})
    end
end
