function [ meanTime, stdTime] = mysgdsvm( filename, k, numruns )
%MYSGDSVM Main function of SVM- Pegasos Algorithm 
% iterate through the num of runs provided as the parameter to this
% function, and report the mean and standard deviation of the execution
% time of the pegasos algorithm

global lambda data;

lambda=2;

data=csvread(filename);
timeSpent=zeros(size(numruns,1));
objectiveCell=cell(1,numruns);
objectiveBallCell=cell(1,numruns);
for i=1: numruns
    [timeSpent(i),objectiveFn, objectiveFn_ball] = pegasos(10000,k);
    objectiveBallCell{i}=objectiveFn_ball;   
    objectiveCell{i}=objectiveFn;
end

figure;
title('Pegasos Algorithm')
xlabel('No. of Iterations');
ylabel('Objective value with projected W');
for i =1:numruns
hold on;
plot(objectiveBallCell{i});
hold off;    
end

figure;
title('Pegasos Algorithm')
xlabel('No. of Iterations');
ylabel('Objective value without W projected');
for i =1:numruns
hold on;
plot(objectiveCell{i});
hold off;    
end

meanTime=mean(timeSpent);  
stdTime=std(timeSpent);
fprintf('Avg runtime for %d runs with minibatch size of %d: %2f seconds\n',numruns, k, meanTime);
fprintf('Std runtime for %d runs with minibatch size of %d: %2f seconds\n',numruns, k, stdTime);
% write the values of Objective function with projected W onto a file.
dlmwrite('tempQ3.txt',[]);
dlmwrite('tempQ3.txt',objectiveFn,'delimiter','\t'); 

fprintf('Plot data exported to ./tempQ3.txt\n');
end