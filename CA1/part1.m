clear;clc
close all
%% first part 
syms n
x1=piecewise(n<0,0,(n==0),1,(0<n)<4,0,(n==4),1,n>4,0);
x2= piecewise(n<-3,0,(-3<=n)<3,-2,n>=3,0);
x3= x1+x2;% this is where the first function is defined
n1=-10:0.01:10;
n2=-10:10;
%% part x(n)
% this part is fromthe fist part that we are going to plot it
figure 
subplot(2,1,1)
plot(n1,subs(x3,n1));
title('X(n)')
ylim([-2.5,1.5]);
ylabel('x(n)');
xlabel('n')
grid on
subplot(2,1,2)
stem(n2,subs(x3,n2));
ylim([-2.5,1.5]);
title('X(n)')
ylabel('x(n)');
xlabel('n')
grid on
%% part y(n)
% this part is for function y[n] which we are doing it in plot and stem
figure
y1=subs(x3,n1)-subs(x3,2*n1+1);
y2=subs(x3,n2)-subs(x3,2*n2+1);
subplot(2,1,1);
plot(n1,y1)
title('Y(n)')
grid on
ylim([-4.5,1.5]);
ylabel('y(n)');
xlabel('n')
subplot(2,1,2)
stem(n2,real(y2));
ylim([-4.5,1.5]);
ylabel('y(n)');
xlabel('n')
title('Y(n)')
grid on
%% part z(n)
% this part is for function z[n] which we are doing it in plot and stem
% we may need to ranges to plot a better diagram
z1=exp(1j*pi*n1).*cos(pi*n1/2).*subs(x3,n1);
z2=exp(1j*pi*n2).*cos(pi*n2/2).*subs(x3,n2);
figure
subplot(2,1,1)
plot(n1,real(z1));
ylim([-2.5,2.5]);
ylabel('z(n)');
xlabel('n')
title('Z(n)')
grid on
subplot(2,1,2)
stem(n2,real(z2));
ylim([-2.5,2.5]);
ylabel('z(n)');
xlabel('n')
grid on
title('Z(n)');
%% Second part
% we use the functions that are defined in the function pack
% there is ramp function which we already have defined in the functions
n3=-10:10;
n4=-10:0.01:10;
W1=5*(ramp(2-n4)+ramp(n4-2));
w1=5*(ramp(2-n3)+ramp(n3-2));
figure
subplot(2,1,1)
stem(n3,w1);
grid on
title('5*(ramp(2-n3)+ramp(n3-2))');
subplot(2,1,2)
plot(n4,W1);
grid on
title('5*(ramp(2-n3)+ramp(n3-2))');
W2=3*ramp(n4+3)-6*ramp(n4+1)+3*ramp(n4)-3*step_func(n4-3);
w2=3*ramp(n3+3)-6*ramp(n3+1)+3*ramp(n3)-3*step_func(n3-3);
figure
subplot(2,1,1);
stem(n3,w2);
grid on
title('3*ramp(n3+3)-6*ramp(n3+1)+3*ramp(n3)-3*step_func(n3-3)');
subplot(2,1,2);
plot(n4,W2);
grid on
title('5*(ramp(2-n3)+ramp(n3-2))');

%% Functions
function [y]=ramp(x)
y=zeros(1,length(x));
for i=1:length(x)
      if x(1,i)<=0
         y(1,i)=0;
      elseif x(1,i)>0
          y(1,i)=x(1,i);
      end 
end 
end 

function [y]=step_func(x)
y=zeros(1,length(x));
for i=1:length(x)
      if x(1,i)<0
         y(1,i)=0;
      elseif x(1,i)>=0
          y(1,i)=1;
    end 
end 
end



