function  result = takeStep( i1, i2 )

global E K target Alphas C Obj b t X w;
eps = 0.0001;
result = 0;

% Applying the terminating condition here
if  i1 == i2 || t >= 10000 
    return;
end
% when the objective function reaches asymptotic values terminate
if t>2 && abs(Obj(t)-Obj(t-1)) <= 1e-10
     return;
end

alph1 = Alphas(i1);
y1 = target(i1);
alph2 = Alphas(i2);
y2 = target(i2);

E1 = E(i1);
E2 = E(i2);

s = y1*y2;

% Compute L and H
if y1 == y2
    L = max([0 alph1+alph2-C]);
    H = min([C alph1+alph2]);
else
    L = max([0 alph2-alph1]);
    H = min([C C+alph2-alph1]);
end

if L == H;
    return;
end

k11 = K(i1,i1);
k12 = K(i1,i2);
k22 = K(i2,i2);

eta = (2 * k12)-(k11 + k22);

if eta < 0
    a2 = alph2 - y2*(E1-E2)/eta;
    if a2 < L
        a2 = L;
    elseif a2 > H
        a2 = H;
    end
else
    % computer the objective function value at a2=L and a2=H
    Lobj=eta/2*(L^2)+(y2(E1-E2)-eta*alph2)*L;
    Hobj=eta/2*(H^2)+(y2(E1-E2)-eta*alph2)*H;
    
    if Lobj > ( Hobj + eps )
        a2 = L;
    elseif Lobj < ( Hobj-eps )
        a2 = H;
    else
        a2 = alph2;
    end
    
return;
end

if a2 < (1e-8)
    a2=0;
elseif a2 > C-(1e-8)
    a2=C;
end

if abs(a2-alph2)< eps*(a2+alph2+eps)
    return;
end

a1 = alph1 + s*(alph2-a2);

% Update threshold to reflect change in Lagrange multipliers
% updateThreshold(i1,i2,a1,a2);

b1 = E(i1) + y1 * (a1 - alph1) * K(i1,i1) + y2 * (a2 - alph2) * K(i1,i2) + b;
b2 = E(i2) + y1 * (a1 - alph1) * K(i1,i2) + y2 * (a2 - alph2) * K(i2,i2) + b;

if (b1 == b2)
    b = b1;
else
    % one of these alphas is at an edge
    if a1 > 0 && a1 < C
        b = b1;
    elseif a2 > 0 && a2 < C
        b = b2;
    else
        b = (b1+b2)/2;
    end
end

% Update objective function
% Obj= [Obj updateObj];
%Store a1 in the alpha array
%Store a2 in the Alpha array
Alphas(i1) = a1;
Alphas(i2) = a2; 

w= w+ y1*(a1-alph1)*X(i1,:) + y2*(a2-alph2)*X(i2,:);
Obj = [ Obj 0.5*w*w'];


% Update eror cache using new Lagrange multipliers
updateErrorCache(i1,i2);
result = 1;
%keep a check on the no. of times alphas were updated, we will keep it to max 10000 
t=t+1;
end