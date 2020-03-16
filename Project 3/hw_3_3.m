clc; clear all; close all;

load('cam1_3.mat')
fa = size(vidFrames1_3,4);
xa = zeros(1,fa);
ya = zeros(1,fa);
filtera = zeros(480,640);
filtera(121:480,280:480) = ones(360,201);
filterc = zeros(480,640);
filterc(:,240:640)=ones(480,401);
for k = 1:fa
    frame = vidFrames1_3(:,:,:,k);
    frame = imbinarize(filtera.*im2double(rgb2gray(frame)),0.98);
    [yind,xind] = ind2sub([480,640],find(frame));
    xa(k) = round(mean(xind));
    ya(k) = round(mean(yind));
end

%%

load('cam2_3.mat')
fb = size(vidFrames2_3,4);
xb = zeros(1,fb);
yb = zeros(1,fb);

for j = 1:fb
    frame = vidFrames2_3(:,:,:,j);
    frame = imbinarize(im2double(rgb2gray(frame)),0.98);
    [yind,xind] = ind2sub([480 640],find(frame));
    xb(j) = round(mean(xind));
    yb(j) = round(mean(yind));
end

%%

load('cam3_3.mat')
fc = size(vidFrames3_3,4);
xc = zeros(1,fc);
yc = zeros(1,fc);

for l = 1:fc
    frame = vidFrames3_3(:,:,:,l);
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
xa = xa(14:end); ya = ya(14:end);
xc = xc(8:length(xa)+7); yc = yc(8:length(xa)+7);
xb = xb(1:length(xa)); yb = yb(1:length(xa));

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
energy3 = [S(1,1)^2 S(2,2)^2 S(3,3)^2 S(4,4)^2 S(5,5)^2 S(6,6)^2]./sum(sum(S.^2));
save('energy3.mat','energy3');

%%
semilogy([S(1,1) S(2,2) S(3,3) S(4,4) S(5,5) S(6,6)],'rd')

%%
subplot(1,2,1)
compass(U(3,1),U(4,1),'g')
hold on;
compass(U(1,1),U(2,1),'r')
compass(U(5,1),U(6,1),'b')
title('First Basis Vector')
subplot(1,2,2)
compass(U(3,2),U(4,2),'g')
hold on;
compass(U(1,2),U(2,2),'r')
compass(U(5,2),U(6,2),'b')
title('Second Basis Vector')
legend('Cam 2', 'Cam 1', 'Cam 3')