%% ���ܣ��ó�ģ��
%%
%% ���룺Y_miss:��Ǿ�����ȱʧ��ǩ��n*m
%%      X:�������� d*n
%%      L:laplacian���� n*n
%%
%% �����V(nxm') ��ά��ı�Ǿ���
%%      B(m'xm) ��ǽ�ά                           
%%      W(dxm') ӳ�����
%%
function [W,Q,B,V] = trainResult(X, Y, L)
alpha = 1; beta = 1; mu = 1; 
ita = 1;
[pic_num, label_num] = size(Y); 
feature_dim = size(X,1);
r_feature_dim = 50;
r_label_num = 5;

max_iter =1000;
convergence = zeros(1,max_iter);
tol = 1e-6;

V = randn(pic_num, r_label_num); 

B = randn(r_label_num,label_num);
B_I = eye(r_label_num);

Q = randn(feature_dim, r_feature_dim);

W = randn(r_feature_dim,r_label_num);
W_I = eye(r_feature_dim);

%% ��������
for i = 1:max_iter
    grad_V = (ita+1)*V + alpha*V*(B*B') + beta*L*V - alpha*Y*B' - X'*Q*W;
    grad_Q = X*X'*Q*W*W' - X*V*W' + ita*Q;

    %% ����B
    B = alpha*pinv(alpha*V'*V + ita*B_I)*V'*Y;

    %% ����V
    V = V - calcV(V,grad_V,X,Q,W,B,L,Y,alpha,beta,ita)*grad_V;
    
    %% ����Q
    Q = Q - calcQ(Q,grad_Q,X,V,W,ita)*grad_Q;
    for row=1:feature_dim
        row_sq_sum = 0;
        for col=1:r_feature_dim
            row_sq_sum = row_sq_sum + Q(row, col)^2;
        end
        len = sqrt(row_sq_sum);
        for col=1:r_feature_dim
            Q(row, col) = Q(row, col)/len;
        end
        
    end

    %% ����W
    W = pinv((Q'*X)*(Q'*X)' + mu*W_I)*Q'*X*V;
    

    %% 
    convergence(i) = 0.5*norm(V-X'*Q*W,'fro')^2 + 0.5*alpha*norm(Y-V*B,'fro')^2 + ...
                     0.5*beta*trace(V'*L*V)+ 0.5*mu*norm(W,'fro')^2 + ...
                     0.5*ita*(norm(V,'fro')^2 + norm(B,'fro')^2) + norm(Q,'fro')^2; 
    
    if i>1
        
        %fprintf('iteration: %d loss: %.6f value: %.6f \n ',...
        %     i, abs(convergence(i) - convergence(i-1)), convergence(i));
        if abs(convergence(i) - convergence(i-1)) <= tol * abs(convergence(i))
                break;
        end
    end
    if i>max_iter
        fprintf('exceed maximum iterations\n');
        break;
    else
        
    end

    
end

end

