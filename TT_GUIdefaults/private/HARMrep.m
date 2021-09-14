    function HARMrep(src,event)
        if strcmp(src.Checked,'off')
            src.Checked = 'on';
            src.UserData = 'HARMrep';
        else
            src.Checked = 'off';
            src.UserData = [];
        end
    end