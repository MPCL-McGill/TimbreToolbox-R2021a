function PowSTFTrep(src,event)
    if strcmp(src.Checked,'off')
        src.Checked = 'on';
        src.UserData = 'PowSTFTrep';
    else
        src.Checked = 'off';
        src.UserData = [];
    end
end