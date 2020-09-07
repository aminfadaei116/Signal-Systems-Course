clear;clc;close all
%% part a
syms n y(n) x(n) r w0 z
f=y(n)-(r^2)*y(n-2)-2*r*cos(w0)*y(n-1)-x(n);
fzt=ztrans(f,n,z);
syms xzt yzt Hzt
fzt=subs(fzt,ztrans(y(n), n, z),yzt);
fzt=subs(fzt,ztrans(x(n), n, z),xzt);
fzt=subs(fzt,[y(-2) y(-1)],[0 0]);
eq=fzt==0;
yzt=solve(eq,yzt);
Hzt=yzt/xzt;
Hzt=simplifyFraction(Hzt);
pretty(Hzt);
%% part b
poles(Hzt,z)



%% part c
Hzt=subs(Hzt,w0,pi/4);
Hzt=subs(Hzt,r,0.25);
HztPoles=poles(Hzt,z);
HztZeros=solve(Hzt,z);
double(HztPoles)
double(HztZeros)
[N,D]=numden(Hzt);
resu=tf(sym2poly(N),sym2poly(D),0.1);
pzmap(resu)
%% part d
pretty(Hzt)
[b a]=zp2tf(double(HztZeros),double(HztPoles),1);
figure
freqz(b,a);



