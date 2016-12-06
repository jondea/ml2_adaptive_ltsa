function [  ] = plottangentspace( X )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    Xbar = mean(X,1);
    dims = 2;
    
    % Determine which pca to use and get linear fitting
    [n,d] = size(X);
    Q = [];
    if (n>d)
        % calculate the covariance matrix
        cov = (1/(n-1)) .* (X - ones(n,1)*Xbar)' * (X - ones(n,1)*Xbar);
        
        % find the eigenvectors and eigenvalues
        [Q, V] = eig(cov);
        
        % extract diagonal of matrix as vector
        V = diag(V);
        
        % sort the variances in decreasing order
        [junk, rindices] = sort(-1*V);
        Q = Q(:,rindices);
    else
        data = (X - ones(n,1)*Xbar)';
        Y = data' ./ sqrt(n-1);
        [u,S,Q] = svd(Y);
    end    
    
    Q = Q(:,1:dims);
    
    Xmap = (Q' * (X - ones(n,1)*Xbar)');
    
    % Get trial points
    xt = 10;
    mx = min(Xmap(:,1),[],1)-xt;
    my = min(Xmap(:,2),[],1)-xt;
    Mx = max(Xmap(:,1),[],1)+xt;
    My = max(Xmap(:,2),[],1)+xt;
    tdata = [mx, mx, Mx, Mx; my, My, my, My]';
    % Get the mean matrix
    tdatabar = ((ones(4,1))*Xbar);

    tr = tdatabar + (Q*tdata')';
    
    patch(tr([1,2,4,3,1],1)',tr([1,2,4,3,1],2)',tr([1,2,4,3,1],3)',[1,1,1,1,1],'FaceAlpha',0.7);
    

end

