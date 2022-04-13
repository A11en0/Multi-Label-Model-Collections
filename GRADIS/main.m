%threshold�ǹ���������ǵ���ֵ
%rate�Ǿ���ı���������
%k��k���ڲ���,�����ƾ���ϡ��̶ȵĲ���
%alpha��ָ���ƶ���Ȩƽ���ļ�Ȩ����
%emotions.mat��ʾ�����ݼ�,p3r3,p5r3,p7r3�ֱ�����������������ı�Ǿ���
%     target = dataset.p3r3_noise_target;%p����������,3��30%,�Դ�����
    threshold = 0.1;
    rate = 0.1;
    k = 8;
    alpha = 0.95;
    dataset = load("Iaprtc12.mat"); 
    data = dataset.data;
    target =  double(dataset.target);
    
    for v =1: length(data)
        dataset.data{v} = double(data{v});
    end
    
%     dataset.data = reshape(data, size(data, 2), size(data, 1));
    noisy_num = 3;
    noisy_ratio = 0.3;
    [y_noisy, noisy_nums] = rand_noisy(dataset.target, noisy_num, noisy_ratio);
    
    n_fold = 5;
    idxs = {};
    [m, d] = size(dataset.data{1});
    kk = randperm(m);
    slice = ceil(m / n_fold);
    
    for fold = 1: n_fold
        idxs{fold, 1} = kk((fold - 1) * slice + 1: min( fold * slice , m ) );
    end
    
    dataset.idx = idxs;
    cvResult  = zeros(16, n_fold);
    
    for fold = 1: n_fold
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
        %         save(['result/',dataname,'/',dataname,'_p3g',num2str(threshold),'r',num2str(rate),'k',num2str(k),'alpha',num2str(alpha),'_',num2str(fold),'_fold_result.mat'],'Outputs','Pre_Labels','test_target','-v7');
        
        fprintf('-- Evaluation\n');
        ResultAll = EvaluationAll(Pre_Labels', Outputs', test_target');
        cvResult(:, fold) = cvResult(:, fold) + ResultAll;
        Avg_Result      = zeros(16,2);
        Avg_Result(:,1) = mean(cvResult,2);
        Avg_Result(:,2) = std(cvResult,1,2);
    end
    PrintResults(Avg_Result);


