     function [sol,y]=c10mga4(sol,options)
     x=sol(1:2); x=x(:); x(3)=(6+4*x(1)-2*x(2))/3;
     y1=[-2 1 1]*x; y2=[-1 1 0]*x;
     if (y1>9 | y2<-4 | x(3)<0), y=-100; else, y=-[1 2 3]*x; end
