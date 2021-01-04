function dy=c7impode(t,x)
dx=@(p,x)[p(1)*sin(x(4))+p(2)^2+2*x(1)*x(3)*...
          exp(-x(2))-x(1)*p(1)*x(4); 
      x(1)*p(1)*p(2)+cos(p(2))-...
          3*x(3)*x(2)*exp(-x(1))];
ff=optimset; ff.Display='off';
dx1=fsolve(dx,x([1,3]),ff,x);
dy=[x(2); dx1(1); x(4); dx1(2)];
