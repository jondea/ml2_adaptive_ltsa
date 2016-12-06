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

[D1, ni1, nbhd1] = adaptive_find_nn(X, 70, 2);
[D2, ni2, nbhd2] = adaptive_find_nn_noexp(X, 70, 2);
[D3, ni3] = find_nn(X, 70);

n11 = ni1(p1,:);
n11 = n11(n11~=0);
n12 = ni1(p2,:);
n12 = n12(n12~=0);

n21 = ni2(p1,:);
n21 = n21(n21~=0);
n22 = ni2(p2,:);
n22 = n22(n22~=0);

n31 = ni3(p1,:);
n31 = n31(n31~=0);
n32 = ni3(p2,:);
n32 = n32(n32~=0);

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


non11 = setdiff([1:2000],n11);
non12 = setdiff([1:2000],n12);

non21 = setdiff([1:2000],n21);
non22 = setdiff([1:2000],n22);

non31 = setdiff([1:2000],n31);
non32 = setdiff([1:2000],n32);

scatter3(X(non31,1)',X(non31,2)',X(non31,3)',10)
hold on
scatter3(X(n31,1)',X(n31,2)',X(n31,3)','rx');
scatter3(X(p1,1)',X(p1,2)',X(p1,3)',50,'ko');
hold off

view([-5,52])
xlim([2.6,5.6])
zlim([-1.1,0.1])
ylim([2,4.5])

scatter3(X(non21,1)',X(non21,2)',X(non21,3)',10)
hold on
scatter3(X(n21,1)',X(n21,2)',X(n21,3)','rx');
scatter3(X(p1,1)',X(p1,2)',X(p1,3)',50,'ko');
hold off

view([-5,52])
xlim([2.6,5.6])
zlim([-1.1,0.1])
ylim([2,4.5])

scatter3(X(non11,1)',X(non11,2)',X(non11,3)',10)
hold on
scatter3(X(n11,1)',X(n11,2)',X(n11,3)','rx');
scatter3(X(p1,1)',X(p1,2)',X(p1,3)',50,'ko');
hold off

view([-5,52])
xlim([2.6,5.6])
zlim([-1.1,0.1])
ylim([2,4.5])

scatter3(X(non11,1)',X(non11,2)',X(non11,3)',10)
hold on
scatter3(X(n11,1)',X(n11,2)',X(n11,3)','rx');
scatter3(X(p1,1)',X(p1,2)',X(p1,3)',50,'ko');
plottangentspace(X(n11,:))
hold off

view([-5,52])
xlim([2.6,5.6])
zlim([-1.1,0.1])
ylim([2,4.5])


scatter3(X(non32,1)',X(non32,2)',X(non32,3)',10)
hold on
scatter3(X(n32,1)',X(n32,2)',X(n32,3)','rx');
scatter3(X(p2,1)',X(p2,2)',X(p2,3)',50,'ko');
hold off

view([33,35])
xlim([2.6,5.4])
zlim([-1.1,0.1])
ylim([1.5,4.5])


scatter3(X(non22,1)',X(non22,2)',X(non22,3)',10)
hold on
scatter3(X(n22,1)',X(n22,2)',X(n22,3)','rx');
scatter3(X(p2,1)',X(p2,2)',X(p2,3)',50,'ko');
hold off

view([33,35])
xlim([2.6,5.4])
zlim([-1.1,0.1])
ylim([1.5,4.5])


scatter3(X(non12,1)',X(non12,2)',X(non12,3)',10)
hold on
scatter3(X(n12,1)',X(n12,2)',X(n12,3)','rx');
scatter3(X(p2,1)',X(p2,2)',X(p2,3)',50,'ko');
hold off

view([33,35])
xlim([2.6,5.4])
zlim([-1.1,0.1])
ylim([1.5,4.5])
