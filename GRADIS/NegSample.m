function sample_data = NegSample(neg_data, sample_num)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    index = randsample(neg_data,sample_num);
    sample_data = neg_data(index,:);
end

