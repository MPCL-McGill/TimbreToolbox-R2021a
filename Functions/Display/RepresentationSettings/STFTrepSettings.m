function [] = STFTrepSettings

fprintf('Available struct fields for the PowSTFTrep and MagSTFTrep: \n\n');

disp('winType     : window type              (default = ''hann'')')
disp('winLength_s : window length in seconds (default = 0.04645)')
disp('hopSize_s   : hop size in seconds      (default = 0.04645/4)')
disp('winLength   : window length in samples')
disp('hopSize     : hop size in samples')

fprintf('Note: The above parameters must be specified either in seconds or in samples. \n\n')
fprintf('winType can only be set to one of the following windows: \n\n')

disp('winType = hann')
disp('winType = hamming')
disp('winType = blackman')
disp('winType = blackmanharris')
disp('winType = flattopwin')
disp('winType = nutallwin')
disp('winType = rectwin')

fprintf('\n\n')
