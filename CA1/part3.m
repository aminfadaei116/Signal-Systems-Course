clear;clc
close all
syms n
format long
x1=piecewise(n<0,0,(n==0),1,(0<n)<4,0,(n==4),1,n>4,0);
x2= piecewise(n<-3,0,(-3<=n)<3,-2,n>=3,0);
x3= x1+x2;% the x3 function is defined lile this
y=subs(x3,n)+subs(x3,2*n+1);% we give the value to the y like this
z=exp(1j*pi*n).*cos(pi*n/2).*subs(x3);% and we also give the value to z lke this
% we need to resieve a rate of time to calculate the rhings
T0=input('please T0= ');
T1=input('please T1= ');
% in this part we use the functions that we have defined in the m file
Energy_x=Energy_func(x3,T0,T1);
Power_x=RMS_func(x3,T0,T1);
Average_x=Average_func(x3,T0,T1);
txt1='The Energy is %f the DC is %f the RMS is %f for x(n) \n';
txt2='The Energy is %f the DC is %f the RMS is %f for z(n) \n';
fprintf(txt1,Energy_x,Average_x,Power_x);
Energy_z=Energy_func(z,T0,T1);
Power_z=RMS_func(z,T0,T1);
Average_z=Average_func(z,T0,T1);
fprintf(txt2,Energy_z,Average_z,Power_z);
%% function Average or the DC value
function [Average]=Average_func(x,T0,T1)
	Average=0;
	for n=T0:1:T1
		Average=Average+subs(x,n);
    end 
    Average=Average/(T1-T0+1);
end
%% function RMS which we call power function 
function [Power]=RMS_func(x,T0,T1)
    Power=Energy_func(x,T0,T1)/(T1-T0+1);
    Power=sqrt(Power);
end
%% function Energy 
function [Energy]=Energy_func(x,T0,T1)
Energy=0;
    for n= T0:1:T1
	Energy=Energy+(subs(x,n)).^2;
    end 

end
