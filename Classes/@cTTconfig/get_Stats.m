function stats = get_Stats(whichStat)
%==========================================================================
% Checks if user suplied sumary statistics are valid.

% INPUT: cell or char: List of user supplied summary statistics.
% OUTPUT: cell of valid summary statitistics.  

% MEMBER OF: cTTconfig.m
%   Updates the properties: SummaryStatistics   
%==========================================================================

% Only these summary stats are accepted:
acceptedStats = {'Mean', 'Median', 'IQR', 'Std', 'Min', 'Max'};

% Convert to cell if whichStat ischar and not "ALL": Avoid code replication
if ischar(whichStat) && ~strcmp(whichStat, 'ALL') 
    whichStat = cellstr(whichStat); 
elseif strcmp(whichStat, 'ALL') % Do all stats
    whichStat = acceptedStats; 
end

stats = {};
for i=1:numel(whichStat) % For all user supplied Stats
    if ismember(whichStat{i}, acceptedStats) % If it's a valid stat
        stats = [stats; whichStat{i}]; % Add to stats
        % Generate subfolder to store the results 
        % stats = [ stats; [soundsDirectory '/' whichStat{i}] ]; 
        % mkdir([sumStatsFolder, '/', whichStat{i}]);
    else % Invalid user supplied stat
        error('Invalid summary statistic: ''%s'' \n%s',...
            whichStat{i}) 
    end
end 

end