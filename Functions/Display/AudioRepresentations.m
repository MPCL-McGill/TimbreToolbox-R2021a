function [] = AudioRepresentations

fprintf('The following Audio Representations are available: \n\n');

disp('ALL           : computes all Audio Representations (not recommended)')
disp('PowSTFTrep    : Power STFT representation (default)')
disp('MagSTFTrep    : Magnitude STFT representation')
disp('HARMrep       : Harmonic representation')
disp('ERBrep        : ERB representation')
disp('TEErep        : Temporal Energy Envelope Representation')
disp('ASrep         : Audio Signal Representation')

fprintf('\n\n')
