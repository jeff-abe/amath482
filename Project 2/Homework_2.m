clc; clear all; close all;
%%
load handel
v = y';
L = length(v);
figure(1)
plot(1:L,v);
xlabel('Time [pts]');
ylabel('Amplitude');
title('Signal of Interest, v(n)');
t = 1:length(v);
k = (2*pi*Fs/length(v))*[0:(length(v)-1)/2 -(length(v)-1)/2:-1];
ks = fftshift(k);
%%
%Gausian Window Gabor
figure(2)
res = [50 100 500];
% 300:1.8e-5 500:5e-5
al = [1.96e-6 7.86e-6 4.9e-5];
for jj = 1:3
    tslide = linspace(0,length(v),res(jj));
    a = al(jj);
    spec = zeros(length(tslide),length(v));
    for j = 1:length(tslide)
        g = exp(-a*(t-tslide(j)).^2);
%         plot(t,g)
%         hold on
%         pause(0.1)
        vg = v.*g;
        vgt = fft(vg);
        spec(j,:) = fftshift(abs(vgt));
    end
    subplot(1,3,jj)
    pcolor(tslide/Fs,ks/(2*pi),spec'/max(spec,[],'all'))
    shading interp
    colormap hot
    title(['Gausian Window with ', int2str(res(jj)),' divisions'])
    axis([0 length(v)/Fs 0 1800])
% subplot(1,4,jj)
% plot(t,exp(-a*(t-tslide(j-2)).^2))
% hold on
% plot(t,exp(-a*(t-tslide(j-3)).^2))
end
%%
%Shannon Window Gabor
figure(3)
width = [2000 1000 500];
for kk = 1:3
    shslide = 1:width(kk):length(v);
    spec2 = zeros(length(shslide),length(v));
    for k = 1:length(shslide)
        s = zeros(1,length(v));
        s(1,shslide(k):shslide(k) + width(kk)) = ones(1,width(kk)+1);
        s = s(1,1:length(v));
        vs = v.*s;
        vst = fft(vs);
        spec2(k,:) = fftshift(abs(vst));
    end
    subplot(1,3,kk)
    pcolor(shslide/Fs,ks/(2*pi),spec2'/max(spec2,[],'all'))
    shading interp
    colormap hot
    title(['Shannon Window with a width of ', int2str(width(kk)),' samples'])
    axis([0 length(v)/Fs 0 1800])
end
%%
%Mexican Hat Filter
figure(4)
stdev = [700 500 300];
shifts = [50 100 300];
for ll = 1:3
    hslide = linspace(1,length(v),shifts(ll));
    st = stdev(ll);
    spec3 =zeros(length(hslide),length(v));
    for l = 1:length(hslide)
        mh = (2/(pi^(1/4)*sqrt(3*st))).*(1-((t-hslide(l))/st).^2).*exp(-(((t-hslide(l))).^2)/(2*st^2));
        vm = v.*mh;
        vmt = fft(vm);
        spec3(l,:) = fftshift(abs(vmt));
    %     plot(t,mh)
    %     hold on;
    end
    subplot(1,3,ll)
    pcolor(hslide/Fs,ks/(2*pi),spec3'/max(spec3,[],'all'))
    shading interp
    colormap hot
    title(['Mexican Hat Filter with ', int2str(shifts(ll)),' divisions'])
    axis([0 length(v)/Fs 0 1800])
%     subplot(1,4,ll)
%     plot(t,(2/(pi^(1/4)*sqrt(3*st))).*(1-((t-hslide(3))/st).^2).*exp(-(((t-hslide(3))).^2)/(2*st^2)))
%     hold on
%     plot(t,(2/(pi^(1/4)*sqrt(3*st))).*(1-((t-hslide(4))/st).^2).*exp(-(((t-hslide(4))).^2)/(2*st^2)))
end

%%
subplot(1,3,1)

res = 100;
tslide = linspace(0,length(v),res);
a = 7.86e-6;
spec = zeros(length(tslide),length(v));
for j = 1:length(tslide)
    g = exp(-a*(t-tslide(j)).^2);
%         plot(t,g)
%         hold on
%         pause(0.1)
    vg = v.*g;
    vgt = fft(vg);
    spec(j,:) = fftshift(abs(vgt));
end
pcolor(tslide/Fs,ks/(2*pi),spec'/max(spec,[],'all'))
shading interp
colormap hot
title('Gausian Window')
axis([0 length(v)/Fs 0 1800])

subplot(1,3,2)

width = 1000;
shslide = 1:width:length(v);
spec2 = zeros(length(shslide),length(v));
for k = 1:length(shslide)
    s = zeros(1,length(v));
    s(1,shslide(k):shslide(k) + width) = ones(1,width+1);
    s = s(1,1:length(v));
    vs = v.*s;
    vst = fft(vs);
    spec2(k,:) = fftshift(abs(vst));
end
pcolor(shslide/Fs,ks/(2*pi),spec2'/max(spec2,[],'all'))
shading interp
colormap hot
title('Shannon Window')
axis([0 length(v)/Fs 0 1800])

subplot(1,3,3)

shifts = 100;
hslide = linspace(1,length(v),shifts);
st = 500;
spec3 =zeros(length(hslide),length(v));
for l = 1:length(hslide)
    mh = (2/(pi^(1/4)*sqrt(3*st))).*(1-((t-hslide(l))/st).^2).*exp(-(((t-hslide(l))).^2)/(2*st^2));
    vm = v.*mh;
    vmt = fft(vm);
    spec3(l,:) = fftshift(abs(vmt));
end
pcolor(hslide/Fs,ks/(2*pi),spec3'/max(spec3,[],'all'))
shading interp
colormap hot
title('Mexican Hat Filter')
axis([0 length(v)/Fs 0 1800])