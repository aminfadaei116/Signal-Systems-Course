clc ;clear
close all
%% part1
% this part is for calculationg the convolve of
[a]=input('enter the firt votex: ');
[b]=input('enter the second vortex: ');
c=hand_conv(a,b);
display(c);
%% part2
% this part we are going to use two functions that are already mentioned
n=-10:10;
x1=(1./(2.^(-n+1))).*(step_func(n+2)-step_func(n-2));% the first signal
subplot(2,1,1);
plot(n,x1);
title('x1');
grid on 
ylim([-1,1.5]);
x2=zeros(1,6);% the second signal
for k=1:6
	for p=-4:k
x2(k)=x2(k)+(sin(2*p)+exp(1j*pi*p)).*(step_func(p+3)-step_func(p-5));
end 
end 
subplot(2,1,2);
plot(1:6,real(x2))
title('x2');
ylim([-1.5,1.5]);
grid on
x3=hand_conv(x2,x1);% this convolve is made by myself
x4=conv(x1,x2);% this is made by matlab function
figure
subplot(2,1,1);
plot(1:length(x1)+length(x2)-1,real(x3));
xlim([1,26]);
title('hand convolved');
grid on
subplot(2,1,2)
plot(1:length(x1)+length(x2)-1,real(x4));
xlim([1,26]);
grid on
title('matlab default conv');
%% part 3
% in this part we define a step function that is mentioned below
n=0:7;
t=step_func(n-1)-step_func(n-5);
% This part we are going to plot all the 10 matrixes
figure
y1=hand_conv(t,t);
subplot(5,1,1);
plot(y1)
title('y1');
grid on
y2=hand_conv(y1,t);
subplot(5,1,2);
plot(y2)
title('y2');
grid on
y3=hand_conv(y2,t);
subplot(5,1,3);
plot(y3)
title('y3')
grid on
y4=hand_conv(y3,t);
subplot(5,1,4);
plot(y4)
grid on
title('y4')
y5=hand_conv(y4,t);
subplot(5,1,5);
plot(y5)
title('y5')
grid on
y6=hand_conv(y5,t);
figure
subplot(5,1,1);
plot(y6)
grid on
title('y6')
y7=hand_conv(y6,t);
subplot(5,1,2);
plot(y7)
title('y7')
grid on
y8=hand_conv(y7,t);
subplot(5,1,3);
plot(y8)
title('y8')
grid on
y9=hand_conv(y8,t);
subplot(5,1,4);
plot(y9)
title('y9')
grid on
y10=hand_conv(y9,t);
subplot(5,1,5);
plot(y10)
title('y10')
grid on
%% Function this is are the functions that we are using 
function [C]=hand_conv(a2,b)
a=flip(a2);
if iscolumn(a)==1
    a=a.';
    b=b.';
end
a_size=length(a);
b_size=length(b);
A=[zeros(1,b_size),a,zeros(1,b_size)];
B=[zeros(1,a_size),b,zeros(1,a_size)];
C=zeros(1,a_size+b_size-1);
for i=1:a_size+b_size-1
	sum=0;	
	for j=1:b_size
		sum=sum+B(a_size+j)*A(i+j);
end
C(i)=sum;
end
C=flip(C);
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