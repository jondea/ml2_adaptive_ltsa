clear;

% data=niceball;
% 
% llet=lle_toolbox(data,2,40);
% basic=ltsa(data,2,40);
% weighted=ltsa_weighted(data,2,20);
% 
% figure('Name','LTSA basic');
% plot(basic(:,1),basic(:,2));
% 
% figure('Name','LTSA weighted');
% plot(weighted(:,1),weighted(:,2),'r');
% 
% figure('Name','LLE');
% plot(llet(:,1),llet(:,2),'r');

linear_data=[2 -3;2 2;2 7;2 15;2 30;40 6;40 25];
dataW=ltsa_weighted(linear_data,1,6);
data=ltsa(linear_data,1,6);

labels=cellstr(num2str([1:length(linear_data)]'));

figure('Name','Original Data');
plot(linear_data(:,1),linear_data(:,2),'b+');
axis([0 71 -4 35]);
text(linear_data(:,1)+0.1,linear_data(:,2),cellstr(num2str([1:length(linear_data)]')))

figure('Name','1D projection - LTSA');
hold on;
plot(zeros(1,size(data)),data,'r-');
plot(zeros(1,size(data)),data,'bo');
text(zeros(1,length(linear_data))+0.08,data,cellstr(num2str([1:length(linear_data)]')))
% axis([-1 1 -0.7 0.35]);
hold off;

figure('Name','1D projection - LTSA weighted');
hold on;
plot(zeros(1,size(dataW)),dataW,'r-');
plot(zeros(1,size(dataW)),dataW,'bo');
text(zeros(1,length(linear_data))+0.08,dataW,cellstr(num2str([1:length(linear_data)]')))
% axis([-1 1 -0.5 0.5]);
hold off;