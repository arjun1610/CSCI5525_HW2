function Obj=updateObj
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
global Alphas K target;
Obj=0;
obj=0;
sumAlphas = sum(Alphas);
for i= 1: size(target,1)
    for j=1: size(target,1)
        obj = obj+ Alphas(i)*Alphas(j)*target(i)*target(j)*K(i,j);
    end;
end
Obj = sumAlphas - 0.5*obj;
end

