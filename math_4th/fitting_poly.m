function P=fitting_poly(type,N,x)
switch type %处理不同的特殊多项式
   case {'P','Legendre'}, P=[1,x]; %Legendre多项式
      for n=2:N, P(n+1)=(2*n-1)/n*x*P(n)-(n-1)/n*P(n-1); end
   case {'T','Chebyshev'} %Chebyshev多项式
      P=[1,x]; for n=2:N, P(n+1)=2*x*P(n)-P(n-1); end
   case {'L','Laguerre'}, P=[1,1-x]; %Laguerre多项式
      for n=2:N, P(n+1)=(2*n-1-x)/n*P(n)-(n-1)/n*P(n-1); end
   case {'H','Hermite'}, %Hermite多项式
      P=[1,2*x]; for n=2:N, P(n+1)=2*x*P(n)-2*(n-1)*P(n-1); end
end
