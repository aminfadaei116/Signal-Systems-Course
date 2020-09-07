clear;clc;close all
%% part a
syms z f(n)
assume(in(n,'integer')&n>=-2);
g=f(n)-f(n-1)-f(n-2);
gzt=ztrans(g,n,z);
syms fzt
gzt=subs(gzt,ztrans(f(n), n, z),fzt);
eq= gzt==0;
eqSol=solve(eq,fzt);
eqSol=subs(eqSol,[f(-1),f(-2)],[1,-1]);
eqSol=simplifyFraction(eqSol);
eqPoles=poles(eqSol,z);
eqZeros=solve(eqSol,z);
fprintf("The eqaution is\n");
pretty(eqSol);
fprintf("The Poles are %f and %f\n \n",double(eqPoles));
fprintf("There is no Zero");
display(eqZeros)
zplane(eqZeros,eqPoles);
firstFun=iztrans(eqSol,z);
pretty(firstFun);
display(firstFun);


