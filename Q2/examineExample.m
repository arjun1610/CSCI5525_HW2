function result = examineExample(i2)
%EXAMINEEXAMPLE Summary of this function goes here
%   Detailed explanation goes here

global E target Alphas C;
result = 0;
y2 = target(i2);
alph2 = Alphas(i2);
tol = 0.001;
E2 = E(i2);

r2 = E2*y2;

if (r2 < -tol && alph2 < C) || (r2 > tol && alph2 > 0)
    nonZeroNonCIndex = find(Alphas ~= 0 & Alphas ~= C);
    if length(nonZeroNonCIndex) > 1
        i1 = secondChoiceHeuristics(i2);
        if takeStep(i1,i2)
            result = 1;
            return;
        end
    end
    % loop over all nonzero and nonC alpha, starting at a random point
    rand_indx = randperm(length(nonZeroNonCIndex));
    for j=1:length(nonZeroNonCIndex)
        i1 = nonZeroNonCIndex(rand_indx(j)); %index of the alpha (nonzero,nonC)
        if takeStep(i1,i2)
            result = 1;
            return;
        end
    end
    % loop over all possible i1, starting at a random point
    rand_indx = randperm(size(target,1));
    for j=1:size(target,1)
        i1 = rand_indx(j);
        if takeStep(i1,i2)
            result = 1;
            return;
        end
    end
end