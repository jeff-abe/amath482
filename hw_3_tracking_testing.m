clc; clear all; close all;

load('cam1_1.mat')
fa = size(vidFrames1_1,4);
xa = zeros(1,226);
ya = zeros(1,226);
filtera = zeros(480,640);
filtera(:,280:400)=ones(480,121);
filterc = zeros(480,640);
filterc(:,260:640)=ones(480,381);
for j = 1:fa
    frame = vidFrames1_1(:,:,:,j);
    frame = imbinarize(filtera.*im2double(rgb2gray(frame)),0.98);
    [yind,xind] = ind2sub([480,640],find(frame));
    xa(j) = round(mean(xind));
    ya(j) = round(mean(yind));
end
%%

load('cam2_1.mat')
fb = size(vidFrames2_1,4);
xb = zeros(1,fb);
yb = zeros(1,fb);

for k = 1:fb
    frame = vidFrames2_1(:,:,:,k);
    frame = imbinarize(im2double(rgb2gray(frame)),0.98);
    [yind,xind] = ind2sub([480 640],find(frame));
    xb(k) = round(mean(xind));
    yb(k) = round(mean(yind));
end

%%

load('cam3_1.mat')
fc = size(vidFrames3_1,4);
xc = zeros(1,fc);
yc = zeros(1,fc);

for l = 1:fc
    frame = vidFrames3_1(:,:,:,l);
    frame = imbinarize(filterc.*im2double(rgb2gray(frame)),0.96);
    [xind,yind] = ind2sub([480 640],find(frame));
    yc(l) = round(mean(yind));
    xc(l) = round(mean(xind));
end
%%

plot(ya/max(ya),'r*:')
%30
hold on;
plot(yb/max(yb),'g*:')
%39
plot(yc/max(yc),'b*:')
%29
legend('Cam 1', 'Cam 2', 'Cam 3')
xlabel('Frame')
ylabel('Normalized Y Position')

%%
for m = 1:length(xa)-35
    plot(xa(m+30:m+35),ya(m+30:m+35),'r*:')
    hold on;
    plot(xb(m+39:m+44),yb(m+39:m+44),'g*:')
    plot(xc(m+29:m+34),yc(m+29:m+34),'b*:');drawnow;
    hold off;
    axis([0 480 0 640])
    pause(0.05)
end
%%
xa = xa(30:end); ya = ya(30:end);
xb = xb(39:length(xa)+38); yb = yb(39:length(xa)+38);
xc = xc(29:length(xa)+28); yc = yc(29:length(xa)+28);
A = [xa; ya; xb; yb; xc; yc];
A = A - mean(A,2);
[U,S,V] = svd(A);
A1 = S(1,1)*U(:,1)*V(:,1)';
%%
plot(A1(2,:),'r*:')
hold on;
plot(A(2,:),'b.-')
plot(A(4,:),'g.-')
plot(A(6,:),'k.-')
axis([0 197 -100 100])
ylabel('Y position'); xlabel('time (frames)')
legend('Rank 1','Cam 1','Cam 2', 'Cam 3')
%%
energy1 = [S(1,1)^2 S(2,2)^2 S(3,3)^2 S(4,4)^2 S(5,5)^2 S(6,6)^2]./sum(sum(S.^2));
save('energy1.mat','energy1');
%%

semilogy([S(1,1) S(2,2) S(3,3) S(4,4) S(5,5) S(6,6)],'rd')
