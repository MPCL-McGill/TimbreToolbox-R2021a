function TEErep(src,event)
    if strcmp(src.Checked,'off')
        src.Checked = 'on';
        src.UserData = 'TEErep';
    else
        src.Checked = 'off';
        src.UserData = [];
    end
end