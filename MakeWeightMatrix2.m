function [ weight_matrix ] = MakeWeightMatrix2(X, N)
%W=MakeWeightMatrix(X, N)
%   X : data matrix
%   N : matrix of neighborhoods where each row is a list of 0 and 1 to
%   identify indexes of neighbours

[rN, cN]=size(N);

% Initialization of the weight matrix with zeros
% The maximum number of neighbours is the number of samples-1 
weight_matrix=zeros(rN,size(X,1)-1);

% For each noughbourhoods
for i=1:rN
    
    % Build the original neighbour data matrix
    k=1;
    for j=1:cN
        if N(i,j)
            nX(k,:)=X(j,:);
            k=k+1;
        end
    end
    
    % Get the number of neighbours in the neighbourhood
    k=k-1;
    
    % Perform the difference between xi belonging to Ni and the mean
    centered=nX-(mean(nX)*ones(k)');
    
    % Perform svd to get the Q matrix
    [Q, ~, ~]=svd(centered);
    
    % Determining the first d largest singular values
    val=eig(X);
    s=0;
    d=1;
    while s/sum(val) <= 0.90
        s=s+val(d);
        d=d+1;
    end
    
    % For the ith neighbourhood the jth weight is (rest is 0)
    for j=1:k
        product=Q(:,d+1:k)'*(current(j)-mean(nX));
        weight_matrix(i,j)=norm(product);
    end
    
end

% Normalizing Local adaptative weights


end