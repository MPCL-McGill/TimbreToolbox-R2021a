function T = do_summaryStats(ts, filename, whichStat)
%==========================================================================
% Returns the summary statistics inside a Table (T).

% TS: Time Series of descriptor values
% FILENAME: Name of the sound file.
% WHICHSTATS: Name of function that computes a particular statistic
% (feval).

% MEMBER FUNCTIONS: 
% Median (default)
% IQR (interquartile range)
% Mean
% Std (standard deviation)
% Min
% Max

% CALLED BY: (all represesentations) do_xxxrep.m
%==========================================================================

Tfilename           = table();
Tfilename.SoundFile = cellstr(filename);
varNames            = ts.Properties.VariableNames;
Tstat               = feval(whichStat, ts, varNames);
% Concatenate the tables
T = [Tfilename, Tstat];
end

function Tmedian = Median(ts, varNames)
Tmedian = table();
for i =2:numel(varNames) % Descriptor names (i=2 -> skip TimeStamps)
    Tmedian.(varNames{i}) = median(ts{:,i}); % Dynamic field naming
end
end

function Tiqr = IQR(ts, varNames)
Tiqr = table();
for i = 2:numel(varNames) % Descriptor names (i=2 -> skip TimeStamps)
    qr = quantile(ts{:,i}, [0.25, 0.75]); % Dynamic field naming
    Tiqr.(varNames{i}) = qr(2) - qr(1); % Interquartile range
end
end

function Tmean = Mean(ts, varNames)
Tmean = table();
for i = 2:numel(varNames) % Descriptor names (i=2 -> skip TimeStamps)
    Tmean.(varNames{i}) = mean(ts{:,i}); % Dynamic field naming
end
end

function Tmin = Min(ts, varNames)
Tmin = table();
for i = 2:numel(varNames) % Descriptor names (i=2 -> skip TimeStamps)
    Tmin.(varNames{i}) = min(ts{:,i}); % Dynamic field naming
end
end

function Tmax = Max(ts, varNames)
Tmax = table();
for i = 2:numel(varNames) % Descriptor names (i=2 -> skip TimeStamps)
    Tmax.(varNames{i}) = max(ts{:,i}); % Dynamic field naming
end
end

function Tstd = Std(ts, varNames)
Tstd = table();
for i = 2:numel(varNames) % Descriptor names (i=2 -> skip TimeStamps)
    Tstd.(varNames{i}) = std(ts{:,i}); % Dynamic field naming
end
end