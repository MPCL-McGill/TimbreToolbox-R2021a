function [s] = get_Descs(validReps, whichDesc)
%==========================================================================
% Validates user supplied audio descriptors.

% VALIDREPS: fieldnames(obj.Representations)  - valid representations
% WHICHDESC: cell or char: List of Descriptors to evaluate.
% OUTPUT: struct: List of descriptors for each representation (rep)

% MEMBER OF: cTTconfig.m
%   Updates the properties: Representations.(rep).descs   
%==========================================================================

% Convert to cell if whichRep ischar and not "ALL": Avoid code replication
if ischar(whichDesc) && ~strcmp(whichDesc, 'ALL') 
    whichDesc = cellstr(whichDesc); 
end

% 1. If 'ALL' do all Representations:  
if strcmp(whichDesc, 'ALL') % Can also be a struct
    % Get the default descriptors for each rep
    s.descsPowSTFT  = cTTconfig.get_default_STFTdescs; 
    s.descsMagSTFT  = cTTconfig.get_default_STFTdescs; 
    s.descsHARM     = cTTconfig.get_default_HARMdescs;
    s.descsTEE      = cTTconfig.get_default_TEEdescs;
    s.descsAS       = cTTconfig.get_default_ASdescs;
    s.descsERB      = cTTconfig.get_default_ERBdescs;
%+++++++++++++++++++++++ ADD REPRESENTATIONS ++++++++++++++++++++++++++++++
% END of 1: strcmp(whichDesc, 'ALL')
    
% 2. If is a cell do user supplied Representations:
elseif iscell(whichDesc)     
    flagPowSTFT = 1; % 1 = NO descs to compute. 
    flagMagSTFT = 1; 
    flagHARM    = 1;
    flagTEE     = 1;
    flagAS      = 1;
    flagERB     = 1; 
%+++++++++++++++++++++++ ADD REPRESENTATIONS ++++++++++++++++++++++++++++++
    % Check and WARN users in case they supplied invalid descriptors.
    cTTconfig.get_invalidDescs(whichDesc); 
%++++++++++++++ADD REPRESENTATIONS inside get_invalidDescs(whichDesc) +++++
    % There will be at least one valid representation 
    % (otherwise the program would have exited already).
    for i=1:numel(validReps) 
        if strcmp(validReps{i}, 'PowSTFTrep')       
            % Update which descriptors to compute for the PowSTFTrep
            s.descsPowSTFT = cTTconfig.check_STFTdescs(whichDesc); 
            % Check if empty - no descs to compute. If not, change the flag to 0. 
            flagPowSTFT = isempty(fieldnames(s.descsPowSTFT));
        elseif strcmp(validReps{i}, 'MagSTFTrep')       
            % Update which descriptors to compute for the PowSTFTrep
            s.descsMagSTFT = cTTconfig.check_STFTdescs(whichDesc); 
            % Check if empty - no descs to compute. If not, change the flag to 0. 
            flagMagSTFT = isempty(fieldnames(s.descsMagSTFT));
        elseif strcmp(validReps{i}, 'HARMrep')       
            % Update which descriptors to compute for the PowSTFTrep
            s.descsHARM = cTTconfig.check_HARMdescs(whichDesc); 
            % Check if empty - no descs to compute. If not, change the flag to 0. 
            flagHARM = isempty(fieldnames(s.descsHARM));
        elseif strcmp(validReps{i}, 'TEErep')       
            % Update which descriptors to compute for the PowSTFTrep
            s.descsTEE = cTTconfig.check_TEEdescs(whichDesc); 
            % Check if empty - no descs to compute. If not, change the flag to 0. 
            flagTEE = isempty(fieldnames(s.descsTEE));
        elseif strcmp(validReps{i}, 'ASrep')       
            % Update which descriptors to compute for the PowSTFTrep
            s.descsAS = cTTconfig.check_ASdescs(whichDesc); 
            % Check if empty - no descs to compute. If not, change the flag to 0. 
            flagAS = isempty(fieldnames(s.descsAS));
        elseif strcmp(validReps{i}, 'ERBrep')       
            % Update which descriptors to compute for the PowSTFTrep
            s.descsERB = cTTconfig.check_ERBdescs(whichDesc); 
            % Check if empty - no descs to compute. If not, change the flag to 0. 
            flagERB = isempty(fieldnames(s.descsERB));
%+++++++++++++++++++++++ ADD REPRESENTATIONS ++++++++++++++++++++++++++++++
        end
    end
    % If there are no descs to compute - ERROR: 
    if all([flagPowSTFT, flagMagSTFT, flagHARM, flagTEE, flagAS, flagERB])
%+++++++++++++++++++++++ ADD REPRESENTATIONS ++++++++++++++++++++++++++++++
        error('No descriptors to compute for the specified representations')
    end
    % END of 2: iscell(whichDesc)
end