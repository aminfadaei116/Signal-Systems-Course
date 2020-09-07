clear;clc;close all
% The mentioned funtion in the question
syms F(x)
T=input('Enter The period of the x(t) function: ');
F=rectangularPulse(x/4)*(abs(x)-1);
A=find_Cn(F,T);
D1=[subs(A,-20:-1),find_C0(F,T),subs(A,1:20)];
figure
subplot(2,1,1)
stem(-20:20,abs(D1));
title('fourier series');
xlabel('Cj');
ylabel('magnetude');
grid on
subplot(2,1,2);
stem(-20:20,angle(D1));
title('the phaze');
grid on
%% Know we can use it for several functions
H=input('Enter the function please: ');
T2=input('Enter the period of the following function: ');
H=eval(H);
G=find_Cn(H,T2);
G2=find_C0(H,T2);
D2=[subs(G,-20:-1),G2,subs(G,1:20)];
figure
subplot(2,1,1)
stem(-20:20,abs(D2));
title('Seri fourier');
xlabel('Cj');
ylabel('magnetude');
grid on
subplot(2,1,2);
stem(-20:20,angle(D2));
title('the phaze');
grid on
%% functions
function A= find_Cn(f,T)
syms n x
A= int(f*exp(-2i*x*n*pi/T),x, -T/2,T/2)/T;
end

function A= find_C0(f,T)
syms x
A=int(f,x,-T/2,T/2)/T;
end