function [x,f1]=intfunc(f,a,b,n)
if nargin<=3, n=100; end; x=linspace(a,b,n); f1=0; F=0; 
for i=1:n-1, F=F+integral(f,x(i),x(i+1),'RelTol',1e-20); f1=[f1, F]; end
