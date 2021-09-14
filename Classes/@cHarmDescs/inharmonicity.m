function obj = inharmonicity(obj)
%==========================================================================
% Computes the inharmonicity. 

% OBJ: cHARMrep

% CALLED BY: do_HARMrep.m
                
% MEMBER OF: cHarmDescs.m 
%==========================================================================

hRank = obj.PartialsFrequencies ./ obj.Pitch';
fract = hRank-floor(hRank); % Fractional part

% Inharmonicity is max. for frequencies detuned by 0.5 from the ideal
% harmonics (fract). 

% Linear ramp starting from 0 to 1 for 50% detuning and going back to 0. 
fract(fract>0.5)    = 1 - fract(fract>0.5); % Center around 0.5
fract               = 2*fract;              % Scale from 0 to 1.

sumAmps = sum(obj.PartialsAmplitudes.^2, 1); % Sum of amplitude values

% Inharmonicity
inh = sum((obj.PartialsAmplitudes.^2) .* fract) ./ sumAmps;

% Replace NaNs with zeros (silent frames).
inh(sumAmps == 0) = 0;

% Transpose for Table format
obj.Inharmonicity =  inh.';

end