%% ���ܣ����ͼ�������Ծ���Wc���Լ�����������˹ӳ���Pc
%%
%% ���룺ѵ������ͼ�����
%%      ѵ��ͼƬ����
%%
%% �����Wcͼ�����ƾ���
%%      Pc�Ⱦ���
function[Wc,Pc]=visual_similarity(Train_X,TrainIndex)

disp('visual_similarity��ʼ')
%���ݼ��Ķ���Ҫ��
k=10;%����ͼ������

[D_knn_pic,sigma_c]=knn_picture(Train_X,TrainIndex,k);

%% Wc
disp('Wc��ʼ��');
pic_num=size(Train_X,2);
% sigma_c=sigma_c/(pic_num*pic_num);%���������ֵ
Wc=zeros(pic_num,pic_num);
for i=1:pic_num
     for j=1:pic_num%��ͼƬi��j�Ľ���ͼ�񼯺��л���j��i�Ľ���ͼ�񼯺��У�=>>Wc�Գƣ�
            if any((TrainIndex(i)==D_knn_pic(:,j))|(TrainIndex(j)==D_knn_pic(:,i)))
                 Wc(i,j)=exp(-(norm(Train_X(:,i)- Train_X(:,j))^2)/(sigma_c^2));
            else
                Wc(i,j)=0;
            end   
      end
 end


%% Pc
disp('Pc��ʼ��');
diag_pc=zeros(1,pic_num);%�������������
for i=1:pic_num
    diag_pc(i)=sum(Wc(i,:))-Wc(i,i);%%һ��ͼƬ����������ͼƬ�������ԣ���ȥ�Լ���
end
Pc=diag(diag_pc);%�����Խǻ����öȾ���Pc
disp('Pc������');

% disp('visual_similarity������')
save('visual_similarity');
end


%% ���ܣ����ڼ���ͼ�������Եľ����KNN�㷨
%%
%% ���룺esp_featureȥ��������ͼ�����
%%      esp_index������ͼ��ͼƬ����
%%      kͼƬ���ڵĸ���
%%
%% �����D_knn_pic����ͼ��������
%%      sigma_c�������Ĳ���
function[D_knn_pic,sigma_c]=knn_picture(Train_X,TrainIndex,k)
disp('knn_pic��ʼ��')
sigma_c=0;%����ΪD_knn_pic������Ԫ��֮��
pic_num=size(Train_X,2);
dist=zeros(pic_num,1);%%����ͼ�����������ͼ��ľ��루��������
D_knn_pic=zeros(k,pic_num);
for i=1:pic_num
    knn_list=zeros(k,1);%k����ӽ���ͼ��c
    for j=1:pic_num
        dist(j)=norm(Train_X(:,i)-Train_X(:,j));%ijͼ��ͼ���������У������ʽ
        sigma_c=sigma_c+dist(j);%i������ͼ����������֮�ͣ���j��ѭ����=������ͼ����������ֵ��
    end
    [~,index]=sort(dist);%ʡ����B����ʡ������������õ�dist
    %%[B,ind]=sort(A)�������B��A������������A���ֲ��䣬
    %ind��B��ÿһ���Ӧ��A �����������B�ĵ�һ����A��λ��!!ind��1����ʾB�е�һ��A��λ�ã�������
    %�����ǰ�������еģ��ҵ�A��λֵ��Ȼ��ԭ��λ�ã�Ȼ���ҵ�ȫͼ�������ҵ���ͼ
    for j=1:k%����������ƣ�����ȡǰk(����С������)
        %~��Ϊ�������кõ����飬
        %���£�����dist�е�����λ�ã�����ʼ��λ����������ind
        ind=TrainIndex(index(j));
        knn_list(j)=ind;%cntԭ����ȫ0����+1֮���ʾ��K����֮�У�
                   %�ҵ�����ͼ���ţ�ԭʼ��ţ�����������ͼ���ʱ��ı�ţ�
    end
     D_knn_pic(:,i)=knn_list;   %cnt_mat����Ϊͼ�������ͼ�����
end
% save('knn_pic')
disp('knn_pic����')
end