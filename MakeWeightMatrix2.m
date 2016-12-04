function [ weight_matrix ] = MakeWeightMatrix2(X, N, d)
%W=MakeWeightMatrix(X, N, [d])
%   X : data matrix
%   N : matrix of neighborhoods where each row is a list of 0 and 1 to
%   identify indexes of neighbours
%   d : low dimension (default 2)

if ~exist('d', 'var')
        d = 2;
end

[rN, cN]=size(N);

% Initialization of the weight matrix with zeros
% The maximum number of neighbours is the number of samples-1 
weight_matrix=zeros(rN,size(X,1)-1);

% For each noughbourhoods
for i=1:rN
   
    % Build the original neighbour data matrix
    Ii=N(i,:);
    Ii=Ii(Ii~=0);
    k=length(Ii);
    Xi=X(Ii,:);
    
    % Perform the difference between xi belonging to Ni and the mean
    centered = Xi - repmat(mean(Xi, 1), [k 1]);
    
    % Perform svd to get the Q matrix
    [Q, ~, ~]=svd(centered');
    
    % For the ith neighbourhood the jth weight is (rest is 0)
    for j=1:k
        product=Q(:,d+1:k)'*(Xi(k,:)-mean(Xi))';
        weight_matrix(i,Ii(j))=norm(product);
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
        if s ~= 0
            weight_matrix(a(j),b(j))=weight_matrix(a(j),b(j))/s;
        end
    end
end

end