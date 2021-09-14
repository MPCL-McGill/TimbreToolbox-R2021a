function [] = gen_resultsSubfolders(resultsDirectory, reps)
%==========================================================================
% Checks whether the folder to store results exists (RESULTSDIRECTORY) and
% generates sub-folders to store time-series of descriptor values according
% to the supplied Representation (REPS).

% RESULTSDIRECTORY: Folder path in which the results will be saved. 
% REPS: Valid representations to compute: (fieldnames(obj.Representations))

% OUTPUT: Generates the neccessary sub-folders to store the results.  

% MEMBER OF: cTTconfig.m  
%==========================================================================

if isfolder(resultsDirectory) % else exit with error.
    if exist([resultsDirectory, '/TimeSeries'], 'dir') 
        warning('The folder in: %s \n%s' , resultsDirectory, ...
            'is not empty. Previous results might be replaced by this analysis.')
        disp('Press any key to continue');
        pause();
    end 
    for i=1:numel(reps)
        if ~exist([resultsDirectory, '/TimeSeries/', reps{i}], 'dir')
            mkdir([resultsDirectory, '/TimeSeries/', reps{i}]);
        end
    end
else % Results folder does not exist - Error.
    error('The folder in: %s \n%s' , resultsDirectory, ...
                 'does not exist.')
end

end