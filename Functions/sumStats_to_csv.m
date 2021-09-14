function [] = sumStats_to_csv(resultsDirectory)
%==========================================================================
% Converts the summaryStatistics.mat into individual .csv files

% RESULTSDIRECTORY: This is where the summaryStatistics.mat should be
% located. The .csv files are stored in the same directory.

% CALLED BY: user
%==========================================================================

S = load([resultsDirectory, '/summaryStatistics.mat']);

reps = fieldnames(S.summaryStatistics);
for i= 1:numel(reps)
    stats = fieldnames(S.summaryStatistics.(reps{i}));
    for j=1:numel(stats)
        T = S.summaryStatistics.(reps{i}).(stats{j}); % Get the table
        csvFilepath = [resultsDirectory, '/', stats{j}, '_', reps{i}, '.csv'];
        writetable(T,csvFilepath,'Delimiter',',');
    end
end

end