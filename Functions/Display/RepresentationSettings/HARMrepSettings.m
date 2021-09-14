function [] = HARMrepSettings

fprintf('Available struct fields for the HARMrep: \n\n');

disp('magnitudeThreshold     : in dBFS (default = -45)')
disp('minPartialsDuration    : in seconds (default = 0.05)')
disp('pitchRange             : in Hz (default = [30, 5000])')
disp('inharmonicityTolerance : between 0 and 1 (default = 0.5)')
fprintf(' \n')
disp('winType     : window type              (default = ''blackman'')')
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
