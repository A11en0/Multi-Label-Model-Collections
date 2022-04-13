function [y_noisy, noisy_nums] = rand_noisy(y,noisy_num,noisy_ratio)
% y �������������ǩ
% noisy_num ÿ��ʵ����ӵ��������� int
% noisy_ratio ����ʵ��ռ���������ı��� double
% y_noisy �������������ǩ
% noisy_nums ������ָʾ����
y_noisy=y;
[N, C]=size(y);
noisy_nums=zeros(N,1);

% ȷ�����������ʵ������
noise_num_p = ceil(noisy_ratio*N); % ����ʵ����
rand_idx_p=randperm(N); % ���ѡ����������
choose_noise_p = rand_idx_p(1:noise_num_p);  % ����ʵ�� index
for p=1:noise_num_p
    i = choose_noise_p(p);
    u_idx=find(y(i,:)==0);  
    U_num=length(u_idx);
    if U_num >= noisy_num
        rand_idx=randperm(U_num);
        rand_label= u_idx(rand_idx(1:noisy_num));
        y_noisy(i,rand_label)=1;
        noisy_nums(i)=noisy_num;
    end
    if U_num <  noisy_num
        y_noisy(i,u_idx)=1;
        noisy_nums(i)=U_num;
    end
end