    function AllDescs(src,event) % Do all Audio Descriptors
        if strcmp(src.Checked,'off')
            src.Checked = 'on';
            src.UserData = 'ALL';
        else
            src.Checked = 'off';
            src.UserData = [];
        end
    end