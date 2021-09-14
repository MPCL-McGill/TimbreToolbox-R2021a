    function minStats(src,event)
        if strcmp(src.Checked,'off')
            src.Checked = 'on';
            src.UserData = 'Min';
        else
            src.Checked = 'off';
            src.UserData = [];
        end
    end