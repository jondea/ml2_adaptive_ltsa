clear;

data=niceball;

llet=lle_toolbox(data,2,40);
basic=ltsa(data,2,40);
weighted=ltsa_weighted(data,2,20);

figure('Name','LTSA basic');
plot(basic(:,1),basic(:,2));

figure('Name','LTSA weighted');
plot(weighted(:,1),weighted(:,2),'r');

figure('Name','LLE');
plot(llet(:,1),llet(:,2),'r');