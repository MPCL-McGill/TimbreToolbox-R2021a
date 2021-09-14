function ERBrep(src,event)
    if strcmp(src.Checked,'off')
        src.Checked = 'on';
        src.UserData = 'ERBrep';
    else
        src.Checked = 'off';
        src.UserData = [];
    end
end