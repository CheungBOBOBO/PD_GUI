function [select_signal, select_data] = find_similar_signal(a)
    % ���ԭʼ����Ϣ�����ݿ���Ϣ
    % a = SavedSignal(1,:);
    a = a(:, [3,4,17,18]);
    SavedSignal = csvread('./pd_noise_all.csv');
    b = SavedSignal(:, [3,4,17,18]);
    b_data = csvread('./pd_noise_all_orig_data.csv');
    
    % ����������Ϣ
    dist = [];
    for i = 1: size(b, 1)
        dist = [dist, norm(b(i,:)-a)];
    end

    % ���վ�������
    [out, idx] = sort([dist]);
    idx = idx(1:min(5,size(idx,2)));

    % �õ����º���ź�
    select_signal = SavedSignal(idx,:);
    select_data = b_data(idx,:);

end


