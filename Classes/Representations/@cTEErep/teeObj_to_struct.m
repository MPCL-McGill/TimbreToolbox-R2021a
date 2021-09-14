function [s] = teeObj_to_struct(obj)
%==========================================================================
% Converts an object (obj) into a struct [s].
% Removes fields that will not be used in the computations of summary
% statistics.

% CALLED BY: do_HARMrep.m
%==========================================================================

fn = fieldnames(obj); 
for i = 1:length(fn)
    val = obj.(fn{i});
    s.(fn{i}) = val; 
end
% Check for empty fields:
% struct2table in do_(rep).m will give an error for empty fields.
for i = 1:length(fn)
    if isempty(s.(fn{i}))
        s = rmfield(s, fn{i}); 
    end
end
% Remove fields not visible to user. 
s = rmfield(s, 'RectifiedWav');
s = rmfield(s, 'PowerEnvelope');
s = rmfield(s, 'NoiseTHD');
s = rmfield(s, 'AttackTHD');
s = rmfield(s, 'DecreaseSlopeTHD');
s = rmfield(s, 'EffectiveDurationTHD');
s = rmfield(s, 'Fs');
end