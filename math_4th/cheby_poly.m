function y=cheby_poly(a,x) %a与x均是列向量
a=a(:); x=x(:); n=length(a); X=[ones(size(x)) x]; %前两列
for i=2:n-1, X(:,i+1)=2*x.*X(:,i)-X(:,i-1); end, y=X*a;
