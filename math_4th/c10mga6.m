     function [sol,y]=c10mga6(sol,options)
     x=sol(1:2); y=-sin(3*x(1)*x(2)+2)-(x(1)-0.1)*(x(2)-1)-x(1)^2-x(2)^2;
