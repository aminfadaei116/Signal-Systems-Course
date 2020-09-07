clear;clc;close all
%% part a
syms z y(n) x(n)
assume(n,'integer');
g=y(n)-2*x(n-1)-x(n)+1.5*y(n-1);
gzt=ztrans(g,n,z);
syms yzt xzt
gzt=subs(gzt,ztrans(x(n),n,z),xzt);
gzt=subs(gzt,ztrans(y(n),n,z),yzt);
gzt=subs(gzt,[x(-1),y(-1)],[0,0]);
eq=gzt==0;
yzt=solve(eq,yzt);
syms Hzt
Hzt=yzt/xzt;
Hzt=simplifyFraction(Hzt);
pretty(Hzt);
pulsRes=Hzt;
pulsRes=iztrans(pulsRes);
pretty(pulsRes);
%% part b
P=poles(Hzt,z)
Z=solve(Hzt,z)
[hz1, hp1, ht1]=zplane(Z,P);
grid on
title("ROC area");

