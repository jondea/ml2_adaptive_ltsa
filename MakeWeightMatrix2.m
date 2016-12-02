function [ weight_matrix ] = MakeWeightMatrix2(X, N, d)
%W=MakeWeightMatrix(X, N, [d])
%   X : data matrix
%   N : matrix of neighborhoods where each row is a list of 0 and 1 to
%   identify indexes of neighbours
%   d : low dimension (default 2)

if ~d
    d=2;
end

[rN, cN]=size(N);

% Initialization of the weight matrix with zeros
% The maximum number of neighbours is the number of samples-1 
weight_matrix=zeros(rN,size(X,1)-1);

% For each noughbourhoods
for i=1:rN
    
    clear('nX');
    
    % Build the original neighbour data matrix
    k=1;
    for j=1:cN
        if N(i,j)
            nX(k,:)=X(N(i,j),:);
            k=k+1;
        end
    end
    nX=nX';
    
    % Get the number of neighbours in the neighbourhood
    k=k-1;
    
    % Perform the difference between xi belonging to Ni and the mean
    for j=1:k
        centered(j,:)=nX(j,:)-mean(nX);
    end
    
    % Perform svd to get the Q matrix
    [Q, ~, ~]=svd(centered);
    
    % For the ith neighbourhood the jth weight is (rest is 0)
    for j=1:k
        product=Q(:,d+1:k)'*(nX(i,j)-mean(nX(i,:)))
        weight_matrix(i,N(i,j))=norm(product);
    end
    
end

% Normalizing Local adaptative weights
for i=1:size(X,1)
    s=0;
    
    % For each example we look for Neighbourhood where it is
    [a, b]=find(N==i);
    
    % Compute the sum of weights for this point
    for j=1:length(a)
        s=s+weight_matrix(a(j),b(j));
    end
    
    % Update each weight
    for j=1:length(a)
        weight_matrix(a(j),b(j))=weight_matrix(a(j),b(j))/s;
    end
end

end