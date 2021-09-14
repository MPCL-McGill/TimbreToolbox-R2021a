    function iqrStats(src,event)
        if strcmp(src.Checked,'off')
            src.Checked = 'on';
            src.UserData = 'IQR';
        else
            src.Checked = 'off';
            src.UserData = [];
        end
    end