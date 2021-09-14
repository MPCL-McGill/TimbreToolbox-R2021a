    function maxStats(src,event)
        if strcmp(src.Checked,'off')
            src.Checked = 'on';
            src.UserData = 'Max';
        else
            src.Checked = 'off';
            src.UserData = [];
        end
    end