clear;clc;close all;
%% part a
[sound_data,Fs]=audioread('music.wav');
play_obj=audioplayer(sound_data,Fs);
playblocking(play_obj);
%% part b
x=fft(sound_data);
y=fftshift(x);
N=length(y);
f=(-N/2:N/2-1)*(Fs/N);
draw(y,f,Fs);
%% part c
f=(-N/2:N/2-1)*(2*pi/N);
draw(y,f,2*pi);
[M1,M2]=butter(6,(2*pi/6)/pi,'low');
new_sound_data=filter(M1,M2,sound_data);
x2=fft(new_sound_data);
y2=fftshift(x2);
N=length(y2);
f=(-N/2:N/2-1)*(2*pi/N);
SNR_res=snr(sound_data,new_sound_data)
draw(y2,f,2*pi);
play_obj=audioplayer(new_sound_data,Fs);
playblocking(play_obj);
%% part d
downsampled_Rdata=downsample(new_sound_data,3);
downsampled_data=downsample(sound_data,3);
x=fft(downsampled_Rdata);
y=fftshift(x);
N=length(y);
f=(-N/2:N/2-1)*(2*pi/N);
draw(y,f,2*pi);
%% part e
x=fft(downsampled_data);
y=fftshift(x);
N=length(y);
f=(-N/2:N/2-1)*(2*pi/N);
draw(y,f,2*pi);
%% h
new_downsound_data=filter(M1,M2,downsampled_Rdata);
x3=fft(new_downsound_data);
y3=fftshift(x3);
N=length(y3);
f=(-N/2:N/2-1)*(2*pi/N);
draw(y3,f,2*pi);
%% part f
play_obj=audioplayer(new_downsound_data,Fs/3);
playblocking(play_obj);
%% part g
play_obj=audioplayer(new_downsound_data,Fs);
playblocking(play_obj);
play_obj=audioplayer(new_downsound_data,Fs/4);
playblocking(play_obj);
%% part h
updata=upsample(new_downsound_data,3);
x3=fft(updata);
y3=fftshift(x3);
N=length(y3);
f=(-N/2:N/2-1)*(2*pi/N);
draw(y3,f,2*pi);
play_obj=audioplayer(updata,Fs);
playblocking(play_obj);
%% part i
Fupdata=filter(M1,M2,updata);
x2=fft(Fupdata);
y2=fftshift(x2);
draw(y2,f,2*pi);
%% part j
SNR_res2=snr(sound_data,Fupdata(3:end))
%% part k
m=[1 1 1];
conv_res=conv(updata,m);
x2=fft(conv_res);
y2=fftshift(x2);
N=length(y2);
f=(-N/2:N/2-1)*(2*pi/N);
draw(y2,f,2*pi);
SNR_res3=snr(sound_data,conv_res(3:end-2))
%% part m
audiowrite('normal_saved.wav',conv_res,Fs);
audiowrite('slow_saved.wav',conv_res,Fs/3);
audiowrite('fast_saved.wav',conv_res,3*Fs);



function draw(x,f,Fs)
figure
subplot(2,1,1)
plot(f,abs(x));
title(['magnetude']);
xlim([-Fs/2, Fs/2]);
subplot(2,1,2)
plot(f,angle(x));
title(['phase']);
xlim([-Fs/2, Fs/2]);
end