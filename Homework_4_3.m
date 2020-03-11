clc; clear all; close all;
load('test3.mat');
load('Testdata3.mat');

data1 = specwavelet(class,Fs/4);
data2 = specwavelet(edm,Fs/4);
data3 = specwavelet(rap,Fs/4);

%%
[U,S,V,w,v1,v2,v3] = class_train3(data1,data2,data3,25,2);

%%
m1 = mean(v1,2); m2 = mean(v2,2); m3 = mean(v3,2);

testwave = specwavelet(testdata3s,Fs/4);
testmat = U'*testwave;
pval = w'*testmat;
answ = [];
for k = 1:size(pval,2)
    vars = [norm(pval(:,k)-m1) norm(pval(:,k)-m2) norm(pval(:,k)-m3)];
    [M,I] = min(vars);
    answ = [answ I];
end
accuracy = nnz(answ==[1 1 1 1 2 2 2 2 3 3 3 3 1 1 1 1 2 2 2 2 3 3 3 3])/length(answ);
%%
plot(v1(1,:),v1(2,:),'r*')
hold on;
plot(v2(1,:),v2(2,:),'g*')
plot(v3(1,:),v3(2,:),'b*')
plot(pval(1,:),pval(2,:),'kd')
plot(m1(1),m1(2),'rd','Linewidth',2)
plot(m2(1),m2(2),'gd','Linewidth',2)
plot(m3(1),m3(2),'bd','Linewidth',2)
legend('Classical','EDM','Rap','Test Data','Location','Best')
title(['Test 3 Classifier with an Accuracy of ' int2str(round(100*accuracy)) '%'])


