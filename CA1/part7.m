clear;clc
close all
%% part a
% this part we define a simple sin function
t=0:0.01:4;
x=sin(2.5*pi*t);
subplot(3,1,1)
plot(t,x)
title('sin(t)')
grid on
ylim([-1.2,1.2]);
xlabel('time');
ylabel('magnitude');
%% part b
% in this part we must put awgn noise on the sin function
y=awgn(x,20);
subplot(3,1,2);
plot(t,y)
title('noisy sin(t)')
grid on
ylim([-1.2,1.2]);
xlabel('time');
ylabel('magnitude');
%% part c
% in this part we use the conv function to get red on some of the noises
m=0.2*ones(1,5);
z=conv(m,y);
n=(1/101)*(0:1:length(x)+length(m)-2);
subplot(3,1,3);
plot(n,z)
title('convolved noisy sin(t)')
grid on
xlim([0,4]);
xlabel('time');
ylabel('magnitude');

