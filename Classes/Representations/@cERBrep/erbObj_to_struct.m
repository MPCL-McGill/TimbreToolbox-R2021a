function [s] = erbObj_to_struct(obj)
%==========================================================================
% Converts an object (obj) into a struct [s].
% The property 'RepValues' is not returned (not needed).
% The property 'CenterFrequencies' is not returned (not needed).

% CALLED BY: do_ERBrep.m
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
s = rmfield(s, 'RepValues');
s = rmfield(s, 'CenterFrequencies');