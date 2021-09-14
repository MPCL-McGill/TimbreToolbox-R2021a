function HARMrepSet(src,event)

% Open the new menu
fig = uifigure('Name', 'HARM Settings','HandleVisibility', 'on');
% Labels:
lbl01 = uilabel(fig);
lbl01.Text = 'Note: window length and hopsize must be specified either';
lbl01.Position = [20 390 400 22];
lbl02 = uilabel(fig);
lbl02.Text = 'in seconds (winLength_s, hopSize_s) or in samples (winLength, hopSize).';
lbl02.Position = [20 375 400 22];

lbl1 = uilabel(fig, 'Text', 'winType:', 'Position',     [50 300 400 22]);
lbl2 = uilabel(fig, 'Text', 'winLength_s:', 'Position', [50 250 400 22]);
lbl3 = uilabel(fig, 'Text', 'hopSize_s:', 'Position',   [50 200 400 22]);
lbl4 = uilabel(fig, 'Text', 'winLength:', 'Position',   [50 150 400 22]);
lbl5 = uilabel(fig, 'Text', 'hopSize:', 'Position',     [50 100 400 22]);

lbl6 = uilabel(fig, 'Text', 'magnitudeThreshold:', 'Position',      [320 300 400 22]);
lbl7 = uilabel(fig, 'Text', 'minPartialsDuration:', 'Position',     [320 250 400 22]);
lbl8 = uilabel(fig, 'Text', 'inharmonicityTolerance:', 'Position',  [320 200 400 22]);
lbl9 = uilabel(fig, 'Text', 'minPitch:', 'Position',                [320 150 400 22]);
lbl10 = uilabel(fig, 'Text','maxPitch:','Position',                 [320 100 400 22]);

winType = uidropdown(fig,'Items',{'hann','hamming','blackman','blackmanharris', 'flattopwin', 'nutallwin', 'rectwin'},...
    'Value', 'blackman', 'Position',                                                      	[130 300 120 22]);
winLength_s = uieditfield(fig,'numeric', 'Limits', [0 +inf], 'Value', 0.04645, 'Position',  [130 250 120 22]);
hopSize_s   = uieditfield(fig,'numeric', 'Limits', [0 +inf], 'Value', 0.04645/4, 'Position',[130 200 120 22]);
winLength   = uieditfield(fig,'numeric', 'Limits', [0 +inf], 'Value', 0, 'Position',        [130 150 120 22]);
hopSize     = uieditfield(fig,'numeric', 'Limits', [0 +inf], 'Value', 0, 'Position',        [130 100 120 22]);

magnitudeThreshold      = uieditfield(fig,'numeric', 'Limits', [-inf, 0], 'Value', -45, 'Position', [460 300 50 22]);
minPartialsDuration     = uieditfield(fig,'numeric', 'Limits', [0, +inf], 'Value', 0.05, 'Position',[460 250 50 22]);
inharmonicityTolerance  = uieditfield(fig,'numeric', 'Limits', [0, 0.5], 'Value', 0.5, 'Position', 	[460 200 50 22]);
minPitch                = uieditfield(fig,'numeric', 'Limits', [0, +inf], 'Value', 30, 'Position',  [460 150 50 22]);
maxPitch                = uieditfield(fig,'numeric', 'Limits', [0, +inf], 'Value', 5000, 'Position',[460 100 50 22]);


% Push button: DONE 
btn = uibutton(fig, 'push', 'Text', 'Done', 'Position',[420, 20, 100, 22],...
        'ButtonPushedFcn',...
        @(btn,event) doneHARMrep(src, winType, winLength_s, hopSize_s, winLength, hopSize, ...
        magnitudeThreshold, minPartialsDuration, inharmonicityTolerance, minPitch, maxPitch));
      
% push button: CANCEL
btnCancel = uibutton(fig,'push', 'Text', 'Cancel', 'Position',[20, 20, 100, 22],...
        'ButtonPushedFcn', @(btnCancel,event) cancelRep(src));
end

function doneHARMrep(src, winType, winLength_s, hopSize_s, winLength, hopSize, ...
    magnitudeThreshold, minPartialsDuration, inharmonicityTolerance, minPitch, maxPitch)
    src.Checked = 'on';
    src.UserData.winType                = winType.Value;
    src.UserData.winLength_s            = winLength_s.Value;
    src.UserData.hopSize_s              = hopSize_s.Value;
    src.UserData.winLength             	= winLength.Value;
    src.UserData.hopSize                = hopSize.Value;
    
    src.UserData.magnitudeThreshold    	= magnitudeThreshold.Value;
    src.UserData.minPartialsDuration   	= minPartialsDuration.Value;
    src.UserData.inharmonicityTolerance = inharmonicityTolerance.Value;
    src.UserData.minPitch               = minPitch.Value;
    src.UserData.maxPitch               = maxPitch.Value;
    close 'HARM Settings';
end

function cancelRep(src)
    src.Checked = 'off';
    src.UserData = [];
    close 'HARM Settings';
end