function dx=c7exdde(t,x,z)
xlag1=z(:,1); xlag2=z(:,2); 
dx=[1-3*x(1)-xlag1(2)-0.2*xlag2(1)^3-xlag2(1); 
     x(3);
    4*x(1)-2*x(2)-3*x(3)];
