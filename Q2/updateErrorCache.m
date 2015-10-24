function updateErrorCache(i1,i2)

%UPDATEERRORCACHE Summary of this function goes here
%   Detailed explanation goes here
global E target;

for i=1:length(E)
    E(i) = svmresult(i) - target(i);
end
E(i2)=0;
E(i1)=0;
end