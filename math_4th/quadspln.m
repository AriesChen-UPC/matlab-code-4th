  function y=quadspln(x0,y0,a,b)
  f=@(x)interp1(x0,y0,x,'spline'); y=integral(f,a,b);
  