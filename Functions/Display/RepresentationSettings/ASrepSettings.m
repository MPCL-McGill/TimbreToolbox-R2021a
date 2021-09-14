function [] = ASrepSettings

fprintf('Available struct fields for the ASrep: \n\n');

disp('winLength_s : window length in seconds (default = 0.04645)')
disp('hopSize_s   : hop size in seconds      (default = 0.04645/2)')
disp('winLength   : window length in samples')
disp('hopSize     : hop size in samples')

disp('Note: These parameters must be specified either in seconds or in samples.')

fprintf('\n\n')
