clear; close all; clc;
load Testdata
L=15; % spatial domain
n=64; % Fourier modes
x2=linspace(-L,L,n+1);
x=x2(1:n);
y=x;
z=x;
k=(2*pi/(2*L))*[0:(n/2-1) -n/2:-1];
ks=fftshift(k);

[X,Y,Z]=meshgrid(x,y,z);
[Kx,Ky,Kz]=meshgrid(ks,ks,ks);
%%
%Example Plot of Original Data
%Ex(:,:,:)=reshape(Undata(1,:),n,n,n);
%figure(1)
%isosurface(X,Y,Z,abs(Ex),0.4)
%axis([-20 20 -20 20 -20 20]), grid on, drawnow
%xlabel('X');ylabel('Y');zlabel('Z');
%hold on;
%%
Ua = zeros(n,n,n);
an = 20;
for j=1:an
    Un(:,:,:)=reshape(Undata(j,:),n,n,n);
    %Average Finding
    Ua = Ua + fftn(Un);
end
Ua = abs(Ua/an);
%Finding Frequency Signature
[M,I] = max(Ua,[],'all','linear');
kx0 = Kx(I);
ky0 = Ky(I);
kz0 = Kz(I);
%Normalizing and Plotting
Ua = Ua/max(Ua,[],'all');
figure(2)
close all, isosurface(Kx,Ky,Kz,abs(Ua),0.97);
hold on
axis([-10 0 0 10 -10 0]), grid on, drawnow

%%
%Building Filter Function
a = 5.5;
f = exp(-a*((Kx-kx0).^2 + (Ky-ky0).^2 + (Kz-kz0).^2));

isv = 0.9;
marble = zeros(20,3);
for j=1:20
    Un(:,:,:)=reshape(Undata(j,:),n,n,n);
    %Applying Filter
    unft = f.*fftn(Un);
    unf = abs(ifftn(unft));
    unf = unf/max(unf,[],'all');
    [M2, I2] = max(unf,[],'all','linear');
    %Plotting Filtered Data
    marble(j,:) = [X(I2) Y(I2) Z(I2)];
    figure(3)
    isosurface(X,Y,Z,abs(unf),isv), grid on, drawnow
    axis([-20 20 -20 20 -20 20]);
    hold on
end
%plotting Trajectory

traj = plot3(marble(:,1),marble(:,2),marble(:,3),'r','Linewidth',2);
title({'Marble Location and Trajectory','Final Location $ = (-6.0938,4.2188,-6.0938)$'},'Interpreter','latex')
grid on
subset = [traj];
legend(subset, 'Trajectory'); xlabel('X'); ylabel ('Y'); zlabel('Z');
fp = marble(20,:);