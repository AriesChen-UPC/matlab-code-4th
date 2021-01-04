function y=legendre_poly(a,x) %a与x均是列向量
a=a(:); x=x(:); n=length(a); X=[ones(size(x)) x]; %前两列
for i=2:n-1, X(:,i+1)=(2*n-1)/n*x.*X(:,i)-(n-1)/n*X(:,i-1); end, y=X*a;
