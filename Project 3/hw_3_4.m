clc; clear all; close all;

load('cam1_4.mat')
fa = size(vidFrames1_4,4);
xa = zeros(1,fa);
ya = zeros(1,fa);
filtera = zeros(480,640);
filtera(121:480,280:480) = ones(360,201);
filterc = zeros(480,640);
filterc(1:320,240:640)=ones(320,401);
for k = 1:fa
    frame = vidFrames1_4(:,:,:,k);
    frame = imbinarize(filtera.*im2double(rgb2gray(frame)),0.97);
    [yind,xind] = ind2sub([480,640],find(frame));
    xa(k) = round(mean(xind));
    ya(k) = round(mean(yind));
end

%%

load('cam2_4.mat')
fb = size(vidFrames2_4,4);
xb = zeros(1,fb);
yb = zeros(1,fb);

for j = 1:fb
    frame = vidFrames2_4(:,:,:,j);
    frame = imbinarize(im2double(rgb2gray(frame)),0.98);
    [yind,xind] = ind2sub([480 640],find(frame));
    xb(j) = round(mean(xind));
    yb(j) = round(mean(yind));
end

%%

load('cam3_4.mat')
fc = size(vidFrames3_4,4);
xc = zeros(1,fc);
yc = zeros(1,fc);

for l = 1:fc
    frame = vidFrames3_4(:,:,:,l);
    imshow(frame)
    frame = imbinarize(filterc.*im2double(rgb2gray(frame)),0.93);
    [xind,yind] = ind2sub([480 640],find(frame));
    xc(l) = round(mean(xind));
    yc(l) = round(mean(yind));
    hold on;
    plot(yc(l),xc(l),'ro');drawnow;
    hold off;
end
%%

plot(ya,'r*')
hold on;
plot(yb,'g*')
plot(yc,'b*')

%%
xa = xa(18:end); ya = ya(18:end);
xc = xc(19:length(xa)+18); yc = yc(19:length(xa)+18);
xb = xb(25:length(xa)+24); yb = yb(25:length(xa)+24);

%%
A = [xa; ya; xb; yb; xc; yc];
A = A - mean(A,2);
[U,S,V] = svd(A);
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
title(['Rank 1 Approximation Preserves ' string(100*energy1) 'Percent of Energy'])
legend('Rank 1','Cam 1','Cam 2', 'Cam 3')
%%
for l = 1:length(xc)-5
    plot(xa(l:l+5),ya(l:l+5),'r*:');
    hold on;
    plot(xb(l:l+5),yb(l:l+5),'g*:');
    plot(xc(l:l+5),yc(l:l+5),'b*:');drawnow;
    hold off;
    axis([0 480 0 640])
    pause(0.05)
end
%%
energy4 = [S(1,1)^2 S(2,2)^2 S(3,3)^2 S(4,4)^2 S(5,5)^2 S(6,6)^2]./sum(sum(S.^2));
save('energy4.mat','energy4');