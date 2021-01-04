     function dx=inv_pendulum(t,x,u,mc,m1,m2,L1,L2,g)
     M=[mc+m1+m2, (0.5*m1+m2)*L1*cos(x(2)), 0.5*m2*L2*cos(x(3))
        (0.5*m1+m2)*L1*cos(x(2)),(m1/3+m2)*L1^2,0.5*m2*L1*L2*cos(x(2))
        0.5*m2*L2*cos(x(3)),0.5*m2*L1*L2*cos(x(2)),m2*L2^2/3];
     C=[0,-(0.5*m1+m2)*L1*cos(x(5))*sin(x(2)),-0.5*m2*L2*x(6)*sin(x(3))
        0, 0, 0.5*m2*L1*L2*x(6)*sin(x(2)-x(3))
        0, -0.5*m2*L1*L2*x(5)*sin(x(2)-x(3)), 0];
     F=[u; (0.5*m1+m2)*L1*g*sin(x(2)); 0.5*m2*L2*g*sin(x(3))];
     dx=[x(4:6); inv(M)*(F-C*x(4:6))];
