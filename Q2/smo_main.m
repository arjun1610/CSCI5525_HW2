function [timespent] = smo_main
%   SMO_MAIN This is the main routine of the smo function 
%   This function computes the timespent on optimizing the dual QP problem
%   and returns the objective function values 
%   
tic;

global Alphas C t;  
numChanged = 0;
examineAll = 1;
t=0;
while (numChanged > 0 || examineAll ) 
    numChanged = 0;
    if examineAll
        for i=1:size(Alphas,1)
            numChanged = numChanged + examineExample(i);
        end
    else
        for i=1:size(Alphas,1)
            if Alphas(i) ~= 0 && Alphas(i) ~= C
                numChanged = numChanged + examineExample(i);
            end
        end
    end    
    if examineAll == 1
        examineAll = 0;
    elseif numChanged == 0
        examineAll = 1;
    end
end
    timespent= toc;
end