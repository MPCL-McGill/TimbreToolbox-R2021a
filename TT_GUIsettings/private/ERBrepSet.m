function ERBrepSet(src,event)

% Open the new menu
fig = uifigure('Name', 'ERB Settings','HandleVisibility', 'on');
% Labels:
lbl01 = uilabel(fig);
lbl01.Text = 'Note: window length and hopsize must be specified either';
lbl01.Position = [20 390 400 22];
lbl02 = uilabel(fig);
lbl02.Text = 'in seconds (winLength_s, hopSize_s) or in samples (winLength, hopSize).';
lbl02.Position = [20 375 400 22];

lbl1 = uilabel(fig, 'Text', 'winLength_s:', 'Position', [180 320 400 22]);
lbl2 = uilabel(fig, 'Text', 'hopSize_s:', 'Position',   [180 270 400 22]);
lbl3 = uilabel(fig, 'Text', 'winLength:', 'Position',   [180 220 400 22]);
lbl4 = uilabel(fig, 'Text', 'hopSize:', 'Position',     [180 170 400 22]);
lbl5 = uilabel(fig, 'Text', 'fLow:', 'Position',        [180 120 400 22]);
lbl6 = uilabel(fig, 'Text', 'nChannels:', 'Position',	[180 70 400 22]);

winLength_s = uieditfield(fig,'numeric', 'Limits', [0 +inf], 'Value', 0.02, 'Position',	[270 320 120 22]);
hopSize_s   = uieditfield(fig,'numeric', 'Limits', [0 +inf], 'Value', 0.01, 'Position', [270 270 120 22]);
winLength   = uieditfield(fig,'numeric', 'Limits', [0 +inf], 'Value', 0, 'Position', 	[270 220 120 22]);
hopSize     = uieditfield(fig,'numeric', 'Limits', [0 +inf], 'Value', 0, 'Position',    [270 170 120 22]);
fLow        = uieditfield(fig,'numeric', 'Limits', [0 +inf], 'Value', 50, 'Position',  	[270 120 120 22]);
nChannels  	= uieditfield(fig,'numeric', 'Limits', [0 +inf], 'Value', 64, 'Position',  	[270 70 120 22]);

% Push button: DONE 
btn = uibutton(fig, 'push', 'Text', 'Done', 'Position',[420, 20, 100, 22],...
        'ButtonPushedFcn',...
        @(btn,event) doneERBrep(src, winLength_s, hopSize_s, winLength, hopSize, fLow, nChannels));
      
% push button: CANCEL
btnCancel = uibutton(fig,'push', 'Text', 'Cancel', 'Position',[20, 20, 100, 22],...
        'ButtonPushedFcn', @(btnCancel,event) cancelRep(src));
end

function doneERBrep(src, winLength_s, hopSize_s, winLength, hopSize, fLow, nChannels)
    src.Checked = 'on';
    src.UserData.winLength_s    = winLength_s.Value;
    src.UserData.hopSize_s      = hopSize_s.Value;
    src.UserData.winLength      = winLength.Value;
    src.UserData.hopSize        = hopSize.Value;
    src.UserData.fLow           = fLow.Value;
    src.UserData.nChannels      = nChannels.Value;
    close 'ERB Settings';
end

function cancelRep(src)
    src.Checked = 'off';
    src.UserData = [];
    close 'ERB Settings';
end