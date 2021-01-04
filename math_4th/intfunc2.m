function [yv,xv,F]=intfunc2(f,xm,xM,varargin)
[ym,yM,n,m]=default_vals({xm,xM,50,50},varargin{:}); 
xv=linspace(xm,xM,n); yv=linspace(ym,yM,m); d=yv(2)-yv(1);
[x y]=meshgrid(xv,yv); F=zeros(n,m);
for i=2:n, for j=2:m, 
   F(i,j)=integral2(f,xv(1),xv(i),yv(1),yv(j),'RelTol',1e-20); 
end, end
 