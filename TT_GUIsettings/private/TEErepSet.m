function TEErepSet(src,event)

% Open the new menu
fig = uifigure('Name', 'TEE Settings','HandleVisibility', 'on');
% Labels:
lbl1 = uilabel(fig, 'Text', 'noiseTHD:', 'Position',                [180 300 400 22]);
lbl2 = uilabel(fig, 'Text', 'attackTHD:', 'Position',               [180 250 400 22]);
lbl3 = uilabel(fig, 'Text', 'decreaseSlopeTHD:', 'Position',        [180 200 400 22]);
lbl4 = uilabel(fig, 'Text', 'effectiveDurationTHD:', 'Position',    [180 150 400 22]);

noiseTHD            = uieditfield(fig,'numeric', 'Limits', [-inf 0], 'Value', -inf, 'Position', [310 300 50 22]);
attackTHD           = uieditfield(fig,'numeric', 'Limits', [-inf 0], 'Value', 0,    'Position', [310 250 50 22]); 
decreaseSlopeTHD    = uieditfield(fig,'numeric', 'Limits', [-inf 0], 'Value', -12,  'Position', [310 200 50 22]); 
effectiveDurationTHD = uieditfield(fig,'numeric', 'Limits',[-inf 0], 'Value', -20,  'Position', [310 150 50 22]);

% Push button: DONE 
btn = uibutton(fig, 'push', 'Text', 'Done', 'Position',[420, 20, 100, 22],...
        'ButtonPushedFcn',...
        @(btn,event) doneTEErep(src, noiseTHD,attackTHD, decreaseSlopeTHD, effectiveDurationTHD ));
      
% push button: CANCEL
btnCancel = uibutton(fig,'push', 'Text', 'Cancel', 'Position',[20, 20, 100, 22],...
        'ButtonPushedFcn', @(btnCancel,event) cancelRep(src));
end

function doneTEErep(src, noiseTHD, attackTHD, decreaseSlopeTHD, effectiveDurationTHD)
    src.Checked = 'on';
    src.UserData.noiseTHD               = noiseTHD.Value;
    src.UserData.attackTHD              = attackTHD.Value;
    src.UserData.decreaseSlopeTHD       = decreaseSlopeTHD.Value;
    src.UserData.effectiveDurationTHD   = effectiveDurationTHD.Value;
    close 'TEE Settings';
end

function cancelRep(src)
    src.Checked = 'off';
    src.UserData = [];
    close 'TEE Settings';
end