clc; clear all; close all;

load('cam1_2.mat')
fa = size(vidFrames1_2,4);
xa = zeros(1,fa);
ya = zeros(1,fa);
filtera = zeros(480,640);
filtera(:,320:640) = ones(480,321);
filteras = zeros(480,640);
filteras(1:240,1:320) = ones(240,320);
filterc = zeros(480,640);
filterc(:,240:640)=ones(480,401);
for k = 1:fa
    frame = vidFrames1_2(:,:,:,k);
    frame = imbinarize(filtera.*im2double(rgb2gray(frame)),0.98);
    [yind,xind] = ind2sub([480,640],find(frame));
    xa(k) = round(mean(xind));
    ya(k) = round(mean(yind));
end

%%

load('cam2_2.mat')
fb = size(vidFrames2_2,4);
xb = zeros(1,fb);
yb = zeros(1,fb);

for j = 1:fb
    frame = vidFrames2_2(:,:,:,j);
    frame = imbinarize(im2double(rgb2gray(frame)),0.98);
    [yind,xind] = ind2sub([480 640],find(frame));
    xb(j) = round(mean(xind));
    yb(j) = round(mean(yind));
end

%%

load('cam3_2.mat')
fc = size(vidFrames3_2,4);
xc = zeros(1,fc);
yc = zeros(1,fc);

for l = 1:fc
    frame = vidFrames3_2(:,:,:,l);
    frame = imbinarize(filterc.*im2double(rgb2gray(frame)),0.96);
    [xind,yind] = ind2sub([480 640],find(frame));
    xc(l) = round(mean(xind));
    yc(l) = round(mean(yind));
end
%%

plot(ya,'r*')
hold on;
plot(yb,'g*')
plot(yc,'b*')

%%
xa = xa(12:end); ya = ya(12:end);
xb = xb(1:length(xa)); yb = yb(1:length(xa));
xc = xc(16:length(xa)+15); yc = yc(16:length(xa)+15);

%%
A = [xa; ya; xb; yb; xc; yc];
A = A - mean(A,2);
AS = [smooth(xa)';smooth(ya)';smooth(xb)';smooth(yb)';smooth(xc)';smooth(yc)'];
AS = AS - mean(AS,2);
[U,S,V] = svd(A);
[U2,S2,V2] = svd(AS);
A1 = S(1,1)*U(:,1)*V(:,1)';
energy1 = S(1,1)^2/sum(sum(S.^2));
energy2 = S(2,2)^2/sum(sum(S.^2));
%%

plot(A1(1,:),'r*:')
hold on;
plot(A(2,:),'b.-')
plot(A(4,:),'g.-')
plot(A(6,:),'k.-')
axis([0 303 0 640])
ylabel('Y position'); xlabel('time (frames)')
legend('Rank 1','Cam 1','Cam 2', 'Cam 3')
%%
for l = 1:length(xa)-5
    plot(xa(l:l+5),ya(l:l+5),'r*:');
    hold on;
    plot(xb(l:l+5),yb(l:l+5),'g*:');
    plot(xc(l:l+5),yc(l:l+5),'b*:');drawnow;
    hold off;
    axis([0 480 0 640])
    pause(0.05)
end
%%
energy2 = [S(1,1)^2 S(2,2)^2 S(3,3)^2 S(4,4)^2 S(5,5)^2 S(6,6)^2]./sum(sum(S.^2));
energy2s = [S2(1,1)^2 S2(2,2)^2 S2(3,3)^2 S2(4,4)^2 S2(5,5)^2 S2(6,6)^2]./sum(sum(S2.^2));
save('energy2.mat','energy2');

semilogy(cumsum(energy2),'gd:','Linewidth',2)
hold on;
semilogy(cumsum(energy2s),'yd:','Linewidth',2)
xticks([1 2 3 4 5 6])
legend('Raw Data','With Smothing Function')
ylabel('Percent of Total Energy')
xlabel('Approximation Rank')