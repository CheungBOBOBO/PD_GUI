function [data] = read_pd_data()

% [filename, filepath] = uigetfile('*');
% full_name = [filepath filename];

full_name = 'F:\�ַ�GUI\PDData2\ygy_gui\C2Trace00011.trc';

% judge if trc or txt
if strcmp(full_name(length(full_name)-2:length(full_name)), 'trc')
    trc_flag = 1;
else
    trc_flag = 0;
end

% get data from txt or trc
if trc_flag
    data = ReadLeCroyBinaryWaveform(full_name);
    data=data.y*1000;
else
    fileID = fopen(full_name);
    data = fscanf(fileID, '%f');
    fclose(fileID);
    data = data*1000;
end


end