function [pd] = prpd_analysis(full_name)

% ��ȡ���ݻ���ļ�
[data] = read_pd_data(full_name);
[features, data_cell] = extract_signal2(data, -1);

% pd=0��ʼֵ 
pd =0
% load('features.mat');

% ��ȡ����
l_rise_time = features(:, 4);
l_loc = features(:, 1);
l_flag = features(:, 7);
l_pv = features(:, 6);
l_t = features(:, 17);
l_w = features(:, 18);
l_tw = [l_t, l_w];


% TW����
k = 3;
color_l = ['r.', 'b.', 'm.', 'y.', 'c.'];
if ((length(l_tw))<3)
    return
end
[kmeans_idx, ctrs] = kmeans(l_tw, k);


for k=1:3
    % ��ÿ�������PRPD��λͼ��
    for i = 1:k
        % get subset data�� �õ��þ����������
        l_loc_sub = l_loc(kmeans_idx==i);
        l_theta_sub = l_loc_sub./2000000.*2.*pi;
        l_pv_sub = l_pv(kmeans_idx==i);
        l_flag_sub = l_flag(kmeans_idx==i);
        if (length(l_loc_sub)<3)    
            continue;
        end
        % get pos and neg parts �����������ݷֿ�
        pos_theta = l_theta_sub(l_flag_sub==1);
        pos_pv = l_pv_sub(l_flag_sub==1);
        neg_theta = l_theta_sub(l_flag_sub==-1);
        neg_pv = l_pv_sub(l_flag_sub==-1);
        length(pos_theta);
        length(neg_theta);

        %��������ͶӰ��x,y����
        pos_x = pos_pv.*cos(pos_theta);
        pos_y = pos_pv.*sin(pos_theta);
        neg_x = neg_pv.*cos(neg_theta);
        neg_y = neg_pv.*sin(neg_theta);


        %% k==1 ����ŵ�

        if (length(pos_theta)<1 | length(neg_theta)<1) 
            display('no k==1');
        else    

            % �����������
            [pos_idx1, pos_ctrs1_] = kmeans([pos_x, pos_y], 1);
            [neg_idx1, neg_ctrs1_] = kmeans([neg_x, neg_y], 1);
            % ����任
            [pos_theta_, pos_rho_] = cart2pol(pos_ctrs1_(:,1), pos_ctrs1_(:,2))
            [neg_theta_, neg_rho_] = cart2pol(neg_ctrs1_(:,1), neg_ctrs1_(:,2))
            pos_ctrs1 = [pos_theta_, pos_rho_];
            neg_ctrs1 = [neg_theta_, neg_rho_];

            pos_ctr_theta = pos_ctrs1(1);
            pos_ctr_pv = pos_ctrs1(2);
            neg_ctr_theta = neg_ctrs1(1);
            neg_ctr_pv = neg_ctrs1(2);

            diff_angle = abs(pos_ctr_theta-neg_ctr_theta);
            display('!!!k=1');
            display(diff_angle) ;
            if (diff_angle>pi*0.9 & diff_angle<pi*1.1)  %�ŵ��о�
               display('!!!pd') ;
               pd = 1;
               return
            end
        end

        %% k==2 ˫��ŵ�

        % k==2
        if (length(pos_theta)<2 | length(neg_theta)<2) 
            display('no k==2');
        else
            % �����������
            [pos_idx2, pos_ctrs2_] = kmeans([pos_x, pos_y], 2);
            [neg_idx2, neg_ctrs2_] = kmeans([neg_x, neg_y], 2);
            % ����任
            [pos_theta_, pos_rho_] = cart2pol(pos_ctrs2_(:,1), pos_ctrs2_(:,2))
            [neg_theta_, neg_rho_] = cart2pol(neg_ctrs2_(:,1), neg_ctrs2_(:,2))
            pos_ctrs2 = [pos_theta_, pos_rho_];
            neg_ctrs2 = [neg_theta_, neg_rho_];

            pos_ctrs2 = sort(pos_ctrs2);
            neg_ctrs2 = sort(neg_ctrs2);  

            %����������ĵ�Ƕ�
            diff_angle1 = abs(pos_ctrs2(1)-neg_ctrs2(1));
            diff_angle2 = abs(pos_ctrs2(2)-neg_ctrs2(2));
            %�����������ĵ�Ƕ�
            neg_angle1 = abs(pos_ctrs2(1)-pos_ctrs2(2));
            neg_angle2 = abs(neg_ctrs2(1)-neg_ctrs2(2));

            %�о�
            if (diff_angle1>pi*0.9 & diff_angle1<pi*1.1) & ...
               (diff_angle2>pi*0.9 & diff_angle2<pi*1.1) & ...
               ((neg_angle1>pi/3*0.9 & neg_angle1<pi/3*1.1) | (neg_angle1>pi*2/3*0.9 & neg_angle1<pi*2/3*1.1))   & ...
               ((neg_angle2>pi/3*0.9 & neg_angle2<pi/3*1.1) | (neg_angle2>pi*2/3*0.9 & neg_angle2<pi*2/3*1.1))
               display('!!!pd') 
               pd = 2;
               return;
            end


        end

        %% k==3 ����ŵ�

        if (length(pos_theta)<3 | length(neg_theta)<3) 
            display('no k==3');
        else
            % k==3
            % �����������
            [pos_idx3, pos_ctrs3_] = kmeans([pos_x, pos_y], 3);
            [neg_idx3, neg_ctrs3_] = kmeans([neg_x, neg_y], 3);


            % ����任
            [pos_theta_, pos_rho_] = cart2pol(pos_ctrs3_(:,1), pos_ctrs3_(:,2))
            [neg_theta_, neg_rho_] = cart2pol(neg_ctrs3_(:,1), neg_ctrs3_(:,2))
            pos_ctrs3 = [pos_theta_, pos_rho_];
            neg_ctrs3 = [neg_theta_, neg_rho_];
            
            pos_ctrs3 = sort(pos_ctrs3);
            neg_ctrs3 = sort(neg_ctrs3);



            %����������ĵ�Ƕ�
            diff_angle1 = abs(pos_ctrs3(1)-neg_ctrs3(1));
            diff_angle2 = abs(pos_ctrs3(2)-neg_ctrs3(2));
            diff_angle3 = abs(pos_ctrs3(3)-neg_ctrs3(3));
            %�����������ĵ�Ƕ�
            neg_angle1 = abs(pos_ctrs3(1)-pos_ctrs3(2));
            neg_angle2 = abs(pos_ctrs3(2)-pos_ctrs3(3));
            neg_angle3 = abs(neg_ctrs3(1)-neg_ctrs3(2));
            neg_angle4 = abs(neg_ctrs3(2)-neg_ctrs3(3));

            %�о�
            if (diff_angle1>pi*0.9 & diff_angle1<pi*1.1) & ...
               (diff_angle2>pi*0.9 & diff_angle2<pi*1.1) & ...
               (diff_angle3>pi*0.9 & diff_angle3<pi*1.1) & ...
               ((neg_angle1>pi/3*0.9 & neg_angle1<60*1.1) | (neg_angle1>pi*2/3*0.9 & neg_angle1<pi*2/3*1.1))   & ...
               ((neg_angle2>pi/3*0.9 & neg_angle2<60*1.1) | (neg_angle2>pi*2/3*0.9 & neg_angle2<pi*2/3*1.1))   & ...
               ((neg_angle3>pi/3*0.9 & neg_angle3<60*1.1) | (neg_angle3>pi*2/3*0.9 & neg_angle3<pi*2/3*1.1))   & ...
               ((neg_angle4>pi/3*0.9 & neg_angle4<60*1.1) | (neg_angle4>pi*2/3*0.9 & neg_angle4<pi*2/3*1.1))   
               display('!!!pd') 
               pd = 3;
               return

            end


        end

    end
end

end