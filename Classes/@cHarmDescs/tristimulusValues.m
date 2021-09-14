function obj = tristimulusValues(obj)
%==========================================================================
% Computes the Tristimulus Values (t1, t2, and t3). 

% OBJ: cHARMrep

% CALLED BY: do_HARMrep.m
                
% MEMBER OF: cHarmDescs.m 
%==========================================================================

sumAmps = sum(obj.HarmonicAmps, 1); % Sum of amplitude values

if size(obj.HarmonicAmps, 1) > 4
    t1 = obj.HarmonicAmps(1, :)             ./ sumAmps;
    t2 = sum(obj.HarmonicAmps(2:4, :),   1) ./ sumAmps;
    t3 = sum(obj.HarmonicAmps(5:end, :), 1) ./ sumAmps;
    % Replace NaNs with zeros (silent frames).
    t1(sumAmps == 0) = 0;
    t2(sumAmps == 0) = 0;
    t3(sumAmps == 0) = 0;
elseif size(obj.HarmonicAmps, 1) > 2
    t1 = obj.HarmonicAmps(1,:)              ./ sumAmps;
    t2 = sum(obj.HarmonicAmps(2:end, :), 1) ./ sumAmps;
    t3 = zeros(1, length(sumAmps));
    % Replace NaNs with zeros (silent frames).
    t1(sumAmps == 0) = 0;
    t2(sumAmps == 0) = 0;
else
    t1 = ones   (1, length(sumAmps));
    t2 = zeros  (1, length(sumAmps));
    t3 = zeros  (1, length(sumAmps));
    % Replace ones with zeros (silent frames).
    t1(sumAmps == 0) = 0;
end

% Transpose for Table format
obj.Tristimulus_1 =  t1.';
obj.Tristimulus_2 =  t2.';
obj.Tristimulus_3 =  t3.';

end