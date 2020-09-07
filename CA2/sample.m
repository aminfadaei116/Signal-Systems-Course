%% Diffrencial equations by Mehdi Moghaddami
clear ;clc; close all
 %az tabe ode45 estefad emikonim
[t, y]=ode45(@fun ,[0,20],[1 ,-1]);
% az dastor dsolve estefad emikonim
syms x
f=dsolve('(2+x^2)*D2y-x*Dy+4*y=0','Dy(0)=-1,y(0)=1',x);
x=0:.1:20;
f=eval(f);
a=zeros(1,1002);
a(1)=1;
a(2)=-1;
for i= 1:100
    a(i+2)=-((i^2-2*i+4)/(2*(i+2)*(i+1)))*a(i);
end 
x=0:0.1:20;
y=zeros(1,201);
for j=1:100
    y=y+a(j).*x.^j;
    
    
end 
plot(x,y);