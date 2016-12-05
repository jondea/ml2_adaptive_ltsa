hold off;
X = rand(2000,3);
X = X .* (2*pi);
X(:,3) = sin(X(:,1)) .* -sin(X(:,1));
c = zeros(1,2000);
p1 = max(((X(:,1) < 4.8) & (X(:,1) > 4.6) & (X(:,2) < 3.3) & (X(:,2) > 2.9)) .* [1:2000]')
p2 =  max(((X(:,1) < 4.1) & (X(:,1) > 3.9) & (X(:,2) < 3.3) & (X(:,2) > 2.9)) .* [1:2000]')
c(p1) = 1;
c(p2) = 0.5;
scatter3(X(:,1)',X(:,2)',X(:,3)',10,c)
colormap winter;

[D, ni, nbhd] = adaptive_find_nn(X, 70, 2);

n1 = ni(p1,:);
n1 = n1(n1~=0);
n2 = ni(p2,:);
n2 = n2(n2~=0);
size(n1)
size(n2)
hold on;

scatter3(X(n1,1)',X(n1,2)',X(n1,3)','rx');
scatter3(X(n2,1)',X(n2,2)',X(n2,3)','g+');

xlim([2.6,5.4])
zlim([-1.1,0.1])
ylim([2,4.5])

%plottangentspace(X(n2,:))
%plottangentspace(X(n1,:))