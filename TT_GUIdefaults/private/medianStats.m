   function medianStats(src,event)
        if strcmp(src.Checked,'off')
            src.Checked = 'on';
            src.UserData = 'Median';
        else
            src.Checked = 'off';
            src.UserData = [];
        end
    end