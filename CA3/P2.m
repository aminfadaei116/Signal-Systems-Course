clear;clc;close all
%% Start of part A
Fs = 8192;
numberOfSeconds = 2;
n = 1 : numberOfSeconds*Fs;
f0 = 660;
w0 = 2*pi*f0/Fs;
x = cos(w0*n);
y = cos(w0*n).*cos(w0*n/3);
v = y.*cos(2*pi*n*140/Fs);
%%
sound(v);
x1=fft(x);
y1=fft(y);
v1=fft(v);
%%
x1sh=fftshift(x1);
y1sh=fftshift(y1);
v1sh=fftshift(v1);
%%
N=length(n);
f=(-N/2:N/2-1)*(Fs/N);
%%
draw(x1sh,f,Fs);
draw(y1sh,f,Fs);
draw(v1sh,f,Fs);




function draw(x,f,Fs)
figure
subplot(2,1,1)
plot(f,abs(x));
xlim([-Fs/2, Fs/2]);
title(['magnetude']);
subplot(2,1,2)
plot(f,angle(x));
title(['phase']);
xlim([-Fs/2, Fs/2]);
end