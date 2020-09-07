clear;clc
close all
%% Plot
t=-10:0.01:10;
 c=1;
x=imag(2-exp(1-c*t*1i));% we have done it right here
x_abs=abs(x);
x_ang=angle(x);
figure
plot(t,x_abs,t,x_ang);% the plot resulte is from here
title('x graph');
ylabel('magnetude');
grid on
lgd1=legend('absolute','angle');
title(lgd1,'x');
% we define the second function here
w=-10*pi:0.01:10*pi;
X=1j.*w./(1+1j.*w);
X_abs=abs(X);
X_ang=angle(X);
figure
plot(w,X_abs,w,X_ang);% the plot resulte is here
title('X graph')
ylabel('phase (radian)')
grid on
lgd2=legend('absolute','angle');
title(lgd2,'X');
%% Stem
n=-10:10;
% we are goign to show the diagram in seperate figures
x_g=imag(2-exp(1-c*n*1i));
figure 
stem(n,abs(x_g));
grid on
title('x_g absolute')
figure
stem(n,angle(x_g));
title('x_g angle')
grid on 
% here is the second function
n=-10*pi:10*pi;
X_g=1j.*n./(1+1j.*n);
figure 
stem(n,abs(X_g));
grid on
title('X_g absolute')
xlim([-32,31]);
figure
stem(n,angle(X_g));
title('X_g angle')
grid on
xlim([-32,31]);