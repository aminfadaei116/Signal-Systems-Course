close all;clear;clc
syms x w
%% part B
syms F1(x) F2(x) F3(x)
F1(x)=piecewise(x<0,0,(4>=x)&(x>=0),1,x>4,0);
F2(x)=piecewise(x~=0,sin(x)*sin(2*x)/(x*pi)^2,2/pi^2);
F3(x)=sin(100*x)*exp(-1j*pi*x);
%% this thing
syms G1(w) G2(w) G3(w)
G1(w)=symsum(F1(x)*exp(-1j*w*x),x,0,4);
G2(w)=symsum(F2(x)*exp(-1j*w*x),x,-100,100);
G3(w)=symsum(F3(x)*exp(-1j*w*x),x,-100,100);
n=-50:50;
H1=G1(n);
H2=G2(n);
H3=G3(n);
%% Draw F1
figure 
subplot(3,1,1)
stem([-10:10],F1([-10:10]));
grid on
subplot(3,1,2)
plot(n,abs(H1));
title('magnetude');
grid on
subplot(3,1,3)
plot(n,angle(H1));
grid on
title('phaze');
%% Draw F2
figure 
subplot(3,1,1)
stem([-5:5],F2([-5:5]));
grid on
subplot(3,1,2)
plot(n,abs(H2));
grid on
title('magnetude');
subplot(3,1,3)
plot(n,angle(H2));
grid on
title('phaze');
% Draw F3
figure 
subplot(3,1,1)
stem([-10:10],F3([-10:10]));
grid on
subplot(3,1,2)
plot(n,abs(H3));
grid on
title('magnetude');
subplot(3,1,3)
plot(n,angle(H3));
grid on
title('phaze');
%% part C
syms t
X1=exp(-t^2/8);
X2=exp(-3*abs(t))*sin(2*t);
FF1=fourier(X1);
FF2=fourier(X2);
figure 
subplot(3,1,1)
ezplot(X1)
grid on
title('The function');
subplot(3,1,2)
ezplot(abs(FF1));
grid on
title('The magnetude');
subplot(3,1,3)
ezplot(angle(FF1));
grid on
title('The Faz');
figure 
subplot(3,2,1)
ezplot(X2);
grid on
title('The function');
subplot(3,1,2)
ezplot(abs(FF2));
grid on
title('The magnetude');
subplot(3,1,3)
ezplot(angle(FF2))
grid on
title('The Faz');

