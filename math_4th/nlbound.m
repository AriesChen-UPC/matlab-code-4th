  function [t,y]=nlbound(funcn,funcv,tspan,x0f,tol,varargin)
  t0=tspan(1);tfinal=tspan(2); ya=x0f(1); yb=x0f(2); m=1; m0=0;
  while (norm(m-m0)>tol), m0=m;
     [t,v]=ode45(funcv,tspan,[ya;m;0;1],varargin{:});
     m=m0-(v(end,1)-yb)/(v(end,3));
  end
  [t,y]=ode45(funcn,tspan,[ya;m],varargin{:});