    function ASrep(src,event)
        if strcmp(src.Checked,'off')
            src.Checked = 'on';
            src.UserData = 'ASrep';
        else
            src.Checked = 'off';
            src.UserData = [];
        end
    end