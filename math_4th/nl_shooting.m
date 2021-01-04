     function [t,y]=nl_shooting(p,q,f,tspan,x0f,varargin)
     if isnumeric(p), p=@(t)p; end, if isnumeric(q), q=@(t)q; end
     if isnumeric(f), f=@(t)f; end
     f1=@(t,x)[x(2); -q(t)*x(1)-p(t)*x(2)]; f2=@(t,x)f1(t,x)-[0; f(t)];
     t0=tspan(1); tfinal=tspan(2); ga=x0f(1); gb=x0f(2);
     [t,y1]=ode45(f1,tspan,[1;0],varargin{:}); [t,y2]=ode45(f1,tspan,[0;1],varargin{:});
     [t,yp]=ode45(f2,tspan,[0;0],varargin{:});
     m=(gb-ga*y1(end,1)-yp(end,1))/y2(end,1); 
     [t,y]=ode45(f2,tspan,[ga;m],varargin{:});
