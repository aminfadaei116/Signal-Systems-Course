clear;clc;close all
%% we start the code by defining
Fs=2*pi*8192;
t=linspace(0,1,Fs);
%%
x1=sin(2*pi*1000*t);
x2=sin(2*pi*2000*t);
x3=sin(2*pi*4000*t);
x4=sin(2*pi*6000*t);
%%
play_thing1=audioplayer(x1,Fs);
play_thing2=audioplayer(x2,Fs);
play_thing3=audioplayer(x3,Fs);
play_thing4=audioplayer(x4,Fs);
%% part a
playblocking(play_thing1);
%% part b
playblocking(play_thing2);
playblocking(play_thing3);
playblocking(play_thing4);
%% part c
y1=fft(x1);
y2=fft(x2);
y3=fft(x3);
y4=fft(x4);
%%
y1sh=fftshift(y1);
y2sh=fftshift(y2);
y3sh=fftshift(y3);
y4sh=fftshift(y4);
%%
N=length(y1);
f=(-N/2:N/2-1)*(Fs/N);
draw(y1sh,f,Fs,'2*pi*1000*t');
draw(y2sh,f,Fs,'2*pi*2000*t');
draw(y3sh,f,Fs,'2*pi*4000*t');
draw(y4sh,f,Fs,'2*pi*6000*t');



function draw(x,f,Fs,name)
figure
subplot(2,1,1)
plot(f,abs(x));
title([name,' ', 'magnetude']);
xlim([-Fs/2, Fs/2]);
subplot(2,1,2)
plot(f,angle(x));
title([name,' ' , 'phaze']);
xlim([-Fs/2, Fs/2]);
end