function [X,Y]=diophantine(A,B,C,x)
A1=polycoef(A,x); B1=polycoef(B,x); C1=polycoef(C,x);
n=length(B1)-1; m=length(A1)-1; S=sylv_mat(A1,B1);
C2=zeros(n+m,1); C2(end-length(C1)+1:end)=C1(:); x0=inv(S.')*C2;
X=poly2sym(x0(1:n),x); Y=poly2sym(x0(n+1:end),x);
