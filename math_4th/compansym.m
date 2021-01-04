   function A=compansym(c)
   n=length(c); if min(size(c))>1, error('Input argument must be a vector.'), end
   if n<=1, A=[];
   elseif n==2, A=-c(2)/c(1);
   else, c=c(:).'; A=sym(diag(ones(1,n-2),-1)); A(1,:)=-c(2:n)./c(1);
   end
