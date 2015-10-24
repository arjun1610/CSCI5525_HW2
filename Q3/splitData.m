function splitData (k)
%splitData When K>1, this functions splits the data into classes with equal
%percentages 
%  For dividing date the method is to find out the the index of each class
%  labels, and categorize them. After this, from each class we pick up K/2
%  samples randomly and then join both the class samples into one training
%  matrix.

global Xt yt data;
n_samples=size(data,1);

classindex1 = find(data(:,1)==1);
nX1_k =floor(k/n_samples * size(classindex1,1));
classindex2 = find(data(:,1)~=1);
nX2_k =floor(k/n_samples * size(classindex2,1));
Xt = zeros(nX1_k+nX2_k, size(data,2)-1);
yt= zeros(nX1_k+nX2_k,1);
rand_index1 = randperm(size(classindex1,1));
rand_index2 = randperm(size(classindex2,1));
for i = 1 : nX1_k
    Xt(i,:)=data(classindex1(rand_index1(i)), 2:end);
    yt(i)=data(classindex1(rand_index1(i)),1); 
end
for i = 1 : nX2_k
    Xt(nX1_k+i,:)=data(classindex2(rand_index2(i)), 2:end);
    yt(nX1_k+i)=data(classindex2(rand_index2(i)),1); 
end
end

