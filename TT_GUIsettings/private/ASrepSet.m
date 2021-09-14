function ASrepSet(src,event)

% Open the new menu
fig = uifigure('Name', 'AS Settings','HandleVisibility', 'on');
% Labels:
lbl01 = uilabel(fig);
lbl01.Text = 'Note: window length and hopsize must be specified either';
lbl01.Position = [20 390 400 22];
lbl02 = uilabel(fig);
lbl02.Text = 'in seconds (winLength_s, hopSize_s) or in samples (winLength, hopSize).';
lbl02.Position = [20 375 400 22];

lbl1 = uilabel(fig, 'Text', 'winLength_s:', 'Position', [180 270 400 22]);
lbl2 = uilabel(fig, 'Text', 'hopSize_s:', 'Position',   [180 220 400 22]);
lbl3 = uilabel(fig, 'Text', 'winLength:', 'Position',   [180 170 400 22]);
lbl4 = uilabel(fig, 'Text', 'hopSize:', 'Position',     [180 120 400 22]);

winLength_s = uieditfield(fig,'numeric', 'Limits', [0 +inf], 'Value', 0.04645, 'Position',	[270 270 120 22]);
hopSize_s   = uieditfield(fig,'numeric', 'Limits', [0 +inf], 'Value', 0.04645/2, 'Position',[270 220 120 22]);
winLength   = uieditfield(fig,'numeric', 'Limits', [0 +inf], 'Value', 0, 'Position',        [270 170 120 22]);
hopSize     = uieditfield(fig,'numeric', 'Limits', [0 +inf], 'Value', 0, 'Position',        [270 120 120 22]);


% Push button: DONE 
btn = uibutton(fig, 'push', 'Text', 'Done', 'Position',[420, 20, 100, 22],...
        'ButtonPushedFcn',...
        @(btn,event) doneASrep(src, winLength_s, hopSize_s, winLength, hopSize));
      
% push button: CANCEL
btnCancel = uibutton(fig,'push', 'Text', 'Cancel', 'Position',[20, 20, 100, 22],...
        'ButtonPushedFcn', @(btnCancel,event) cancelRep(src));
end

function doneASrep(src, winLength_s, hopSize_s, winLength, hopSize)
    src.Checked = 'on';
    src.UserData.winLength_s    = winLength_s.Value;
    src.UserData.hopSize_s      = hopSize_s.Value;
    src.UserData.winLength      = winLength.Value;
    src.UserData.hopSize        = hopSize.Value;
    close 'AS Settings';
end

function cancelRep(src)
    src.Checked = 'off';
    src.UserData = [];
    close 'AS Settings';
end