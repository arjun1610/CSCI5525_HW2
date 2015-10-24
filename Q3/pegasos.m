function [timespent, objFn, objFn_ball]  = pegasos(max_iter,k)
%PEGASOS - This is the implementation of Pegasos algorithm 
%   Mini-batch Pegasos algorithm works in batches of input samples, which
%   are picked up randomly.
tic;
global Xt yt lambda data;
w=zeros(size(data,2)-1,1);
w_array=zeros(size(data,2)-1,max_iter);
for t=1:max_iter
    if k == 1
        %random picking 1 sample from the dataset
        index=randperm(size(data,1),1);
        Xt=data(index,2:end);
        yt=data(index,1);
    else
        splitData(k);
    end
    % change class labels to -1 which are not 1
    n_inputs = size(Xt,1);
    for i = 1:n_inputs
        if yt(i) ~= 1
            yt(i)= -1;
        end
    end
    
    %indicator function value
    ind= ( yt .* (Xt * w)) < 1;
    eta_t=1/(lambda*t);
    w= (1- 1/t)* w + (eta_t/k)* Xt'*(yt.* ind);
    loss = 1 - (yt .* (Xt * w));
    idx = loss > 0;
    objFn(t) = 1/2 * lambda * w' * w + (1/n_inputs) * sum(max(loss,idx));
    
    %project w onto a sphere of radius (1/sqrt(lambda))
    w = min(1, 1 / (sqrt(lambda) * norm(w))) * w;
    w_array(:,t)=w;
    loss = 1 - (yt .* (Xt * w));
    idx = loss > 0;
    objFn_ball(t) = 1/2 * lambda * w' * w + (1/n_inputs) * sum(max(loss,idx));
    
    % terminating condition
    if(t~=1 && (norm(w_array(:,t)-w_array(:,t-1)) <= 0.01))
        break;
    end
end
timespent=toc;
end