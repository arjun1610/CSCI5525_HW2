function i1  = secondChoiceHeuristics( i2 )
%SECONDCHOICEHEURISTICS Summary of this function goes here
% find second choice heuristic - to maximize step size
% As per mentioned in the book, choose maxmimum of negative error if label
% positive, or choose minikum of positive error if label negative
% we calculate the maximum of the |E1-E2|, wherever the maximum lies, 
%we assign the index value to i1, 

global E Alphas C;
E2 = E(i2);
nonZeroNonCIndex = find(Alphas ~= 0 & Alphas ~= C);
[~,maxInd]=max(abs(E2-E(nonZeroNonCIndex)));
i1=maxInd;
end