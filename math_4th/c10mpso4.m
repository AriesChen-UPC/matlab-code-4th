  function y=c10mpso4(x)
  x3=(6+4*x(1)-2*x(2))/3; x=[x x3]';
  y1=[-2 1 1]*x; y2=[-1 1 0]*x; y=[1 2 3]*x;
  if y1>9|y2<-4|x3<0, y=100; end
