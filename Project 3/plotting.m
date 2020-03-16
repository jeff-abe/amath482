clc; clear all; close all;
load('energy1.mat')
load('energy2.mat')
load('energy3.mat')
load('energy4.mat')

semilogy(100*cumsum(energy1),'rd:','Linewidth',2)
hold on;
semilogy(100*cumsum(energy2),'gd:','Linewidth',2)
semilogy(100*cumsum(energy3),'bd:','Linewidth',2)
semilogy(100*cumsum(energy4),'cd:','Linewidth',2)
xticks([1 2 3 4 5 6])
legend('1','2','3','4')
ylabel('Percent of Total Energy')
xlabel('Approximation Rank')