function index = SpectralClustering(W,k)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    W = (W+W')/2;
    m = size(W, 1);
    D = full(sum(W,2));
    D = D.^(-0.5);
    temp = spdiags([D],[0],m,m);
    L = temp*W*temp;
    [V,D] = eigs(L,k,'sm');    
    V = [real(V),imag(V)];
    [index,Dsum,z] = kmeans(V,k);
end
