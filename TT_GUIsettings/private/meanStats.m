    function meanStats(src,event)
        if strcmp(src.Checked,'off')
            src.Checked = 'on';
            src.UserData = 'Mean';
        else
            src.Checked = 'off';
            src.UserData = [];
        end
    end