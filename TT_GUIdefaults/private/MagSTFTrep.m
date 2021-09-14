    function MagSTFTrep(src,event)
        if strcmp(src.Checked,'off')
            src.Checked = 'on';
            src.UserData = 'MagSTFTrep';
        else
            src.Checked = 'off';
            src.UserData = [];
        end
    end
