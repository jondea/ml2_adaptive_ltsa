function [D, ni, nbhd] = adaptive_find_nn_noexp(X, kmax, dims)
%FIND_NN Finds k nearest neigbors for all datapoints in the dataset
%   X:      N by d matrix of N data samples in d dimensions
%   kmax:   The maximum neighborhood size (Make this smaller to run faster)
%   dims:   The target number of dimensions
%
%	[D, ni, nbhd] = find_nn(X, k)
%   D:      NxN Distance matrix
%   ni:     NxN matrix where the kth value in row i is k if example k is in the
%           neighborhood for example i
%   nbhd:   0,1 matrix of D
%   


nexamples = size(X,1);

nbhd = zeros(nexamples);
dist = zeros(nexamples);
distord = zeros(nexamples);

for i = [1:nexamples]
    point = ((ones(nexamples+1-i,1))*X(i,:));
    
    points = X(i:end,:) - point;
    points = sum(points.^2,2);
    points = sqrt(points);
    
    % Set distances
    dist(i:end,i) = points;
    dist(i,i:end) = points';
    
    % Add ordered distance references
    tdistord = sortrows([dist(i,:)',(1:nexamples)'],1);
    distord(i,:) = tdistord(:,2)';
    
end

% Find initial K nearest neighbors
% Kinit = k0 (we dont have a value for this)
kmin = dims+2;
kinit = kmin*3;
maxdists = sort(dist,2);
maxdists = maxdists(:,kinit);
for i = [1:nexamples]
    nbhd(i,:) = dist(i,:) <= maxdists(i);
end


% Calculate an optimal value for eta
p = zeros(nexamples,1);
maxdif = 0;
pideal = 0;
for i = [1:nexamples]
    % Select points in neighborhood subtract mean
    tX = X(distord(i,1:kinit),:);
    tXbar = ((ones(kinit,1))*mean(tX,1));
    
    % Calculate SVD
    [u,S,PC] = svd((tX-tXbar));
        
    S = diag(S).^2;
    
    % Calculate ri
    p(i) = sqrt(sum(S(dims+1:end)))/sqrt(sum(S(1:dims)));
end
p = sort(p,'descend');
for i = [1:length(p)-1]
    td = (p(i+1)/ p(i));
    if ((td) > maxdif)
        maxdif = td;
        pideal = (p(i+1) + p(i))/2;
    end
end
eta = pideal

% Neighborhood contraction

for i = [1:nexamples]
    kopt = nan;
    rmin = inf;
    for k = [kmax:-1:kmin]
        % Select points in neighborhood and partially normalise
        tX = X(distord(i,1:k),:);
        tXbar = ((ones(k,1))*mean(tX,1));
        
        % Calculate SVD
        [u,S,PC] = svd(tX-tXbar);
        S = diag(S).^2;
        
        % Calculate ri
        r = sqrt(sum(S(dims+1:end)))/sqrt(sum(S(1:dims)));
        
        if (r < eta)
            kopt = k;
            break;
        end
        
        % In case we cant find an ideal k
        if (r < rmin)
            rmin = r;
            kopt = k;
        end
    end
    
    % Set the best neighborhood
    nbhd(i,:) = dist(i,:) < dist(i,distord(i,kopt));
    
end

ni = zeros(nexamples);
for i = [1:nexamples]
    ni(i,:) = (1:nexamples) .* nbhd(i,:);
end

D = dist;

min_network_size = min(sum(ni~=0,2))
max_network_size = max(sum(ni~=0,2))

end
