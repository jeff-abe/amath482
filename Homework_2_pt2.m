clc; clear all; close all;
%%
%Load Piano
[y,Fs] = audioread('music1.wav');
v = y';
% v = v(1:length(v)/10);
tr_piano=length(v)/Fs;  % record time in seconds
% plot((1:length(y))/Fs,y);
% xlabel('Time [sec]'); ylabel('Amplitude');
% title('Mary had a little lamb (piano)');
L = length(v);
figure(1)
plot(1:L,v);
xlabel('Time [pts]');
ylabel('Amplitude');
title('Signal of Interest, v(n)');
t = 1:length(v);
k = (2*pi/tr_piano)*[0:(length(v)/2)-1 -(length(v)/2)-1:-1];
ks = fftshift(k);
ks = ks(1:L);


%%

res = 80;
a = 5.46e-8;
b = 6.5e-7;
tslide = linspace(0,length(v),res);
spec = zeros(length(tslide),length(v));

for j = 1:length(tslide)
    g = exp(-a*(t-tslide(j)).^2);
    %Overtone Filter
    o = exp(-b*(ks-300*2*pi).^2);
%     plot(t,g)
%     hold on;
    vg = v.*g;
    vgt = fftshift(fft(vg));
    spec(j,:) = abs(vgt);
end

pcolor(tslide/Fs,ks/(2*pi),spec')
shading interp
hold on;
% contour(tslide/Fs,ks/(2*pi),spec'/max(spec,[],'all'),6)
title('Piano Musical Score')
axis([0 length(v)/Fs 0 2000])

yline(329.63,'w','Linewidth',1);
yline(293.66,'w','Linewidth',1);
yline(261.63,'w','Linewidth',1);