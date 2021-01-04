  function [sol,f]=c10mga3(sol,options)
  x=sol(1:4);
  f=-(x(1)+x(2))^2-5*(x(3)-x(4))^2-...
     (x(2)-2*x(3))^4-10*(x(1)-x(4))^4;
