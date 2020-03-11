clc; clear all; close all;
load('test1.mat');
load('Testdata1.mat');

%Making Spectrograms
data1 = specwavelet(paak,Fs/4);
data2 = specwavelet(rex,Fs/4);
data3 = specwavelet(strokes,Fs/4);

%% training
[U,S,V,w,v1,v2,v3] = class_train3(data1,data2,data3,20,2);

%% testing
m1 = mean(v1,2); m2 = mean(v2,2); m3 = mean(v3,2);

testwave = specwavelet(testdata1s,Fs/4);
testmat = U'*testwave;
pval = w'*testmat;
answ = [];
for k = 1:size(pval,2)
    vars = [norm(pval(:,k)-m1) norm(pval(:,k)-m2) norm(pval(:,k)-m3)];
    [M,I] = min(vars);
    answ = [answ I];
end
accuracy = nnz(answ==[1 1 1 2 2 2 3 3 3 1 1 1 2 2 2 3 3 3])/length(answ);
%% plotting
plot(v1(1,:),v1(2,:),'r*')
hold on;
plot(v2(1,:),v2(2,:),'g*')
plot(v3(1,:),v3(2,:),'b*')
plot(pval(1,:),pval(2,:),'kd')
plot(m1(1),m1(2),'rd','Linewidth',2)
plot(m2(1),m2(2),'gd','Linewidth',2)
plot(m3(1),m3(2),'bd','Linewidth',2)
legend('Anderson .Paak','Rex Orange County','The Strokes','Test Data','Location','Best')
title(['Test 1 Classifier with an Accuracy of ' int2str(round(100*accuracy)) '%'])


