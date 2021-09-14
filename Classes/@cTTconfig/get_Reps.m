function [s] = get_Reps(whichRep)
%==========================================================================
% Validates user input of Representations and Configuration settings that
% are used to compute them.

% INPUT: cell or char or struct: 
% User supplied Representations and Configuration settings. 
% OUTPUT: struct: Representations configuration settings 
% for each representation.

% MEMBER OF: cTTconfig.m
%   Updates the properties: Representations   
%==========================================================================

% Convert to cell if whichRep ischar and not "ALL": Avoid code replication
if ischar(whichRep) && ~strcmp(whichRep, 'ALL') 
    whichRep = cellstr(whichRep); 
end

% Valid representations (0 = no valid representation is found)
flagRep = 0; 

% 1. If 'ALL' do all Representations:  
if strcmp(whichRep, 'ALL') % Can also be a struct
    flagRep = 1; 
    % Get the default configurations for each rep:
    s.PowSTFTrep.config = cTTconfig.get_default_STFTconfig;
    s.MagSTFTrep.config = cTTconfig.get_default_STFTconfig;
    s.HARMrep.config    = cTTconfig.get_default_HARMconfig;
    s.TEErep.config     = cTTconfig.get_default_TEEconfig;
    s.ASrep.config      = cTTconfig.get_default_ASconfig;
    s.ERBrep.config     = cTTconfig.get_default_ERBconfig;
%+++++++++++++++++++++++ ADD REPRESENTATIONS ++++++++++++++++++++++++++++++
% END of 1: strcmp(whichRep, 'ALL')
    
% 2. If it's a cell do user supplied Representations:
elseif iscell(whichRep) 
    for i=1:numel(whichRep) % For all user supplied Representations  
        if strcmp(whichRep{i}, 'PowSTFTrep') % If it's an PowSTFTrep 
            flagRep = 1; % Found a valid representation
            s.PowSTFTrep.config = cTTconfig.get_default_STFTconfig;
        elseif strcmp(whichRep{i}, 'MagSTFTrep') 
            flagRep = 1; 
            s.MagSTFTrep.config = cTTconfig.get_default_STFTconfig;
        elseif strcmp(whichRep{i}, 'HARMrep') 
            flagRep = 1; 
            s.HARMrep.config = cTTconfig.get_default_HARMconfig;
        elseif strcmp(whichRep{i}, 'TEErep') 
            flagRep = 1; 
            s.TEErep.config = cTTconfig.get_default_TEEconfig;
        elseif strcmp(whichRep{i}, 'ASrep') 
            flagRep = 1; 
            s.ASrep.config = cTTconfig.get_default_ASconfig;  
        elseif strcmp(whichRep{i}, 'ERBrep') 
            flagRep = 1; 
            s.ERBrep.config = cTTconfig.get_default_ERBconfig;
%+++++++++++++++++++++++ ADD REPRESENTATIONS ++++++++++++++++++++++++++++++
        else % It's not a valid representation
            warning(' ''%s'' is an invalid representation and will be ignored.', whichRep{i});
        end              
    end % for all user supplied Representations.
% END of 2: iscell(whichRep)
    
% 3. If it is a struct, do user supplied Representations and Configurations
elseif isstruct(whichRep) 
    % Check all fields:
    userFields = fieldnames(whichRep);
    for i=1:numel(userFields)
        % PowSTFTrep with user's config
        if strcmp(userFields{i}, 'PowSTFTrep') % Get User's value
            flagRep = 1;
            % check_STFTconfig - % Input user's struct.    
            s.PowSTFTrep.config = cTTconfig.check_STFTconfig(whichRep.PowSTFTrep); 
        elseif strcmp(userFields{i}, 'MagSTFTrep') % Get User's value
            flagRep = 1;
            % check_STFTconfig - % Input user's struct.    
            s.MagSTFTrep.config = cTTconfig.check_STFTconfig(whichRep.MagSTFTrep);
        elseif strcmp(userFields{i}, 'HARMrep') % Get User's value
            flagRep = 1;
            % check_HARMconfig - % Input user's struct.    
            s.HARMrep.config = cTTconfig.check_HARMconfig(whichRep.HARMrep);
        elseif strcmp(userFields{i}, 'TEErep') % Get User's value
            flagRep = 1;
            % check_TEEconfig - % Input user's struct.    
            s.TEErep.config = cTTconfig.check_TEEconfig(whichRep.TEErep);
        elseif strcmp(userFields{i}, 'ASrep') % Get User's value
            flagRep = 1;
            % check_ASconfig - % Input user's struct.    
            s.ASrep.config = cTTconfig.check_ASconfig(whichRep.ASrep); 
        elseif strcmp(userFields{i}, 'ERBrep') % Get User's value
            flagRep = 1;
            % check_ERBconfig - % Input user's struct.    
            s.ERBrep.config = cTTconfig.check_ERBconfig(whichRep.ERBrep);
%+++++++++++++++++++++++ ADD REPRESENTATIONS ++++++++++++++++++++++++++++++
        else % It's not a valid representation
            warning(' ''%s'' is an invalid representation and will be ignored.', userFields{i});
        end
    end     % END of 3: isstruct(whichRep)
end     % END of checking user input. 

% Final check.
if ~flagRep
    error('No valid representations to compute.')
end