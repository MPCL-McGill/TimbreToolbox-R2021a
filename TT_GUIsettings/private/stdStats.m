function stdStats(src,event)
    if strcmp(src.Checked,'off')
        src.Checked = 'on';
        src.UserData = 'Std';
    else
        src.Checked = 'off';
        src.UserData = [];
    end
end