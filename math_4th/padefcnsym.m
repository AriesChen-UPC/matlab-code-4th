  function G=padefcnsym(f,r,m)
  c=taylor(f,'Order',r+m+1); c=polycoef(c); c=c(end:-1:1);
  w=-c(r+2:m+r+1)'; vv=[c(r+1:-1:1)'; zeros(m-1-r,1)];
  W=rot90(hankel(c(m+r:-1:r+1),vv)); V=rot90(hankel(c(r:-1:1)));
  X=[1 (W\w)']; y=[1 X(2:r+1)*V'+c(2:r+1)]; dP=X(m+1:-1:1)/X(m+1);
  nP=y(r+1:-1:1)/X(m+1); syms x; G=poly2sym(nP,x)/poly2sym(dP,x);
 