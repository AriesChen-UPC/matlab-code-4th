   function A=vandersym(v)
   n=length(v); v=v(:); A=sym(ones(n)); for j=n-1:-1:1, A(:,j)=v.*A(:,j+1); end