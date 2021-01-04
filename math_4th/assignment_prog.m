function [x,fv,key]=assignment_prog(C)
[n,m]=size(C); c=C(:); A=[];b=[]; Aeq=zeros(2*n,n^2); %约束条件
for i=1:n, Aeq(i,(i-1)*n+1:n*i)=1; Aeq(n+i,i:n:n^2)=1; end
beq=ones(2*n,1); xm=zeros(n^2,1); xM=ones(n^2,1); %求解区域边界
[x,fv,key]=intlinprog(c,1:n^2,A,b,Aeq,beq,xm,xM); x=reshape(x,n,m).';