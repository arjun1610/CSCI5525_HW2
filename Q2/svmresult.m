function value = svmresult(i)
%SVMRESULT Summary of this function goes here
%   Detailed explanation goes here
global K target Alphas b;
%
value = sum(target' .* Alphas' .* K(i,:)) - b;
end