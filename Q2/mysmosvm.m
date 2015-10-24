function [meanTime, stdTime] = mysmosvm( filename, numruns )
%MYSMOSVM - MAIN FILE FOR SVM IMPLEMENTATION USING SMO ALGORITHM
%  This is the main routine function which works on the training
%examples, iterates using the number of runs given as the input and tries
%to optimize the Lagrange Multipliers alphas to obey KKT conditions.
% Once we have the KKT conditions followed, we compute the Dual objective
% function value.

global Alphas E b C K target Obj X;
data=csvread(filename);
X = data(1:2000,2:end);
y = data(1:2000,1);
C = 2;
n_inputs = size(X,1);
%Kernelization of the input vectors
% Linear Kernelizations
% K is the kernel(i,j) matrix
K=zeros(n_inputs);
for i=1:n_inputs
    X1 = X(i,:);
    for j=1:n_inputs
        X2 = X(j,:);
        K(i,j) = dot(X1,X2); 
    end
end
%computing target vector, in this case the labels are 1,3. We will change
%all the labels with 3 to -1. 
target = zeros(n_inputs,1);
for i = 1:n_inputs
    if y(i) ~= 1
        target(i)=-1;
    else
        target(i)=y(i);
    end
end

timeSpent=zeros(size(numruns,1));
objectiveFn=cell(1,numruns);
for i=1: numruns
    Alphas = zeros(size(X,1),1);
    b=0;
    Obj=[];
    E = -target;
    [timeSpent(i)] = smo_main;
    objectiveFn{i}=Obj;
end

meanTime=mean(timeSpent);
stdTime=std(timeSpent);

fprintf('Avg runtime for %d runs: %2f seconds\n',numruns, meanTime);
fprintf('Std runtime for %d runs: %2f seconds\n',numruns, stdTime);
% write the values of Dual Objective function onto a file.
dlmwrite('tempQ2.txt',[]);
dlmwrite('tempQ2.txt',objectiveFn,'delimiter','\t'); 

fprintf('Plot data exported to ./tempQ2.txt\n');
figure;
title('SMO Algorithm')
xlabel('No. of Iterations');
ylabel('Dual Objective Function');

for i =1:numruns
hold on;
plot(objectiveFn{i});
hold off;    
end
end
