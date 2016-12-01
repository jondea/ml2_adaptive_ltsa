function [ weight_matrix ] = MakeWeightMatrix(X, N)
%W=MakeWeightMatrix(X, N)
%   X : data matrix
%   N : matrix of neighborhoods where each row is the index list of
%   neighboors

[rN, cN]=size(N);

% Initialization of the weight matrix with zeros
% The maximum number of neighbours is the number of samples-1 
weight_matrix=zeros(rN,size(X,1)-1);

% For each noughbourhoods
for i=1:rN
    
    % Delete columns with 0 to get the exact numbers of neighbours
    current=N(i,:);
    current=current(:,any(current,1));
    
    % Build the original neighbour data
    for j=1:length(current)
        nX(j,:)=X(N(i,j),:);
    end
    
    % Perform the difference between xi belonging to Ni and the mean
    centered=nX-(mean(nX)*ones(length(current))');
    
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
    for j=1:length(current)
        product=Q(:,d+1:length(current))'*(current(j)-mean(current));
        weight_matrix(i,j)=norm(product);
    end
    
end

% Normalizing Local adaptative weights

end