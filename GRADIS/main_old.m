function main(path,dataname,threshold,rate,k,alpha) 
%threshold�ǹ���������ǵ���ֵ
%rate�Ǿ���ı���������
%k��k���ڲ���,�����ƾ���ϡ��̶ȵĲ���
%alpha��ָ���ƶ���Ȩƽ���ļ�Ȩ����
%emotions.mat��ʾ�����ݼ�,p3r3,p5r3,p7r3�ֱ�����������������ı�Ǿ���
    dataset = load(path);
    target = dataset.target ; %p����������,3��30%,�Դ�����
    target, noisy_nums = random_noisy(target, 0.3);
    for fold = 1:10
        noise_target = target;
        idx = dataset.idx{fold};
        view_num = size(dataset.data,1);
        train_data = dataset.data;
        test_data = cell(view_num,1);
        test_target = dataset.target(idx,:);
        noise_target(idx,:) = [];
        for i=1:view_num
            temp = train_data{i};
            test_data{i} = temp(idx,:);
            temp(idx,:) = [];
            train_data{i} = temp;
        end
        disp(['The ',num2str(fold),'-th fold is going on...']);
        [Pre_Labels,Outputs]=GRADIS(train_data,noise_target,test_data,test_target,threshold,rate,k,alpha);
        save(['result/',dataname,'/',dataname,'_p3g',num2str(threshold),'r',num2str(rate),'k',num2str(k),'alpha',num2str(alpha),'_',num2str(fold),'_fold_result.mat'],'Outputs','Pre_Labels','test_target','-v7');
    end
end
