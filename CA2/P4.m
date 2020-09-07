clear;clc;close all
%% part A
syms x(n)
% defining the function
x(n)=piecewise(n~=0,(1/36)*(sinc(n/6))^2,1/36);
syms G1(w)
G1(w)=symsum(x(n)*exp(-1j*w*n),n,-100,100);
n=-50:50;
H1=G1(n);
%% know we are going to draw it
figure 
subplot(3,1,1)
stem([-10:10],x([-10:10]));
title('main function');
subplot(3,1,2)
plot(n,abs(H1));
title('magnetude');
subplot(3,1,3)
plot(n,angle(H1));
title('phaze');
%% part B
syms c1(n) y1(n) G2(w) c2(n) c3(n) y2(n) y3(n)
c1(n)=exp(-1j*pi*n);
c2(n)=exp(-1j*pi*n/2);
c3(n)=exp(-1j*pi*n/3);
y1(n)=c1(n)*x(n);
y2(n)=c2(n)*x(n);
y3(n)=c3(n)*x(n);
G2(w)=symsum(y1(n)*exp(-1j*w*n),n,-100,100);
G3(w)=symsum(y2(n)*exp(-1j*w*n),n,-100,100);
G4(w)=symsum(y3(n)*exp(-1j*w*n),n,-100,100);
n=-50:50;
H2=G2(n);
H3=G3(n);
H4=G4(n);
%%
figure 
subplot(3,1,1)
plot(n,H2);
title(' wc=pi ');
subplot(3,1,2);
plot(n,H3);
title('wc=pi/2');
subplot(3,1,3);
plot(n,H4);
title('wc=pc/3');
%%
figure 
subplot(3,1,1)
stem([-10:10],y1([-10:10]));
title('main function');
subplot(3,1,2)
plot(n,abs(H2));
title('magnetude');
subplot(3,1,3)
plot(n,angle(H2));
title('phaze');