function c=polycoef(p,x)
c=[]; n=0; p1=p; n1=1; nn=1; if nargin==1, x=symvar(p); end
while (1), c=[c subs(p1,x,0)]; p1=diff(p1,x); n=n+1; n1=n1*n; nn=[nn,n1];
   if p1==0, c=c./nn(1:end-1); c=c(end:-1:1); break;
end, end
