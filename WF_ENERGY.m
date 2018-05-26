function [Ea5,Ea4,Ea3,Ea2,Ea1,Ed5,Ed4,Ed3,Ed2,Ed1]=WF_ENERGY(t,x)
% ����˵��: �ú������źŽ���С���任��������ȡ��ȫ���Լ�ϸ�ڲ��ֵ��źż���������
% t: �źŶ�Ӧ��ʱ��
% x: һά�ź�

%% С���任
% figure(5)
% plot(t,x,'LineWidth',2);xlabel('ʱ�� t/s');ylabel('��ֵ A');
%һάС���ֽ�
[c,l] = wavedec(x,5,'db5');  %����С����������Ϣ
%�ع���1��5��ƽ��ź�
a5 = wrcoef('a',c,l,'db5',5);
a4 = wrcoef('a',c,l,'db5',4);
a3 = wrcoef('a',c,l,'db5',3);
a2 = wrcoef('a',c,l,'db5',2);
a1 = wrcoef('a',c,l,'db5',1);


%��ʾ����ƽ��ź�
% figure(3)
% subplot(5,1,1);plot(a5,'LineWidth',2);ylabel('a5');
% subplot(5,1,2);plot(a4,'LineWidth',2);ylabel('a4');
% subplot(5,1,3);plot(a3,'LineWidth',2);ylabel('a3');
% subplot(5,1,4);plot(a2,'LineWidth',2);ylabel('a2');
% subplot(5,1,5);plot(a1,'LineWidth',2);ylabel('a1');
% xlabel('ʱ�� t/s');



%�ع���1��5��ϸ���ź�
d5 = wrcoef('d',c,l,'db5',5);
d4 = wrcoef('d',c,l,'db5',4);
d3 = wrcoef('d',c,l,'db5',3);
d2 = wrcoef('d',c,l,'db5',2);
d1 = wrcoef('d',c,l,'db5',1);

%��ʾ����ϸ���ź�
% figure(4)
% subplot(5,1,1);plot(d5,'LineWidth',2);ylabel('d5');
% subplot(5,1,2);plot(d4,'LineWidth',2);ylabel('d4');
% subplot(5,1,3);plot(d3,'LineWidth',2);ylabel('d3');
% subplot(5,1,4);plot(d2,'LineWidth',2);ylabel('d2');
% subplot(5,1,5);plot(d1,'LineWidth',2);ylabel('d1');
% xlabel('ʱ�� t/s');




%% С��������������
%�����������
Ea5 = sum(a5.^2)
Ea4 = sum(a4.^2)
Ea3 = sum(a3.^2)
Ea2 = sum(a2.^2)
Ea1 = sum(a1.^2)
%�����������
Ed5 = sum(d5.^2)
Ed4 = sum(d4.^2)
Ed3 = sum(d3.^2)
Ed2 = sum(d2.^2)
Ed1 = sum(d1.^2)

end