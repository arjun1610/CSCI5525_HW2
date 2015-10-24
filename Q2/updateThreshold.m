function updateThreshold( i1,i2,a1,a2 )
%UPDATETHRESHOLD Summary of this function goes here
%   Detailed explanation goes here
 
global K target Alphas E b C;
 
alph1 = Alphas(i1);
alph2 = Alphas(i2);

y1 = target(i1);
y2 = target(i2);
 
E1 = E(i1);
E2 = E(i2);
 
b1 = E1 + y1 * (a1 - alph1) * K(i1,i1) + y2 * (a2 - alph2) * K(i1,i2) + b;
b2 = E2 + y1 * (a1 - alph1) * K(i1,i2) + y2 * (a2 - alph2) * K(i2,i2) + b;

%If both 0 < αi < C and 0 < αj < C then both these thresholds are valid, and they will be equal.
%Andrew Ng's simplified explanation of b = b1;

if b1 == b2
    b = b1; %or b2
else
%     if a1>0  && a1<C 
%         b = b1;
%     elseif a2> 0 && a2<C 
%         b = b2;
%     else
        b = (b1+b2)/2;
    end

end