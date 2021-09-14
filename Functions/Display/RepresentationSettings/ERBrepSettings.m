function [] = ERBrepSettings

fprintf('Available struct fields for the ERBrep: \n\n');

disp('winLength_s : window length in seconds (default = 0.02)')
disp('hopSize_s   : hop size in seconds      (default = 0.01)')
disp('winLength   : window length in samples')
disp('hopSize     : hop size in samples')
fprintf('Note: The above parameters must be specified either in seconds or in samples. \n\n')

disp('fLow        : in Hz, the lowest center frequency of the ERB filterbank (default = 50)')
disp('nChannels   : number of channels (filters) used in the ERB filterbank (default = 64)')

fprintf('\n\n')
