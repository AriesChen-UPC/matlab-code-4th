     function dx=lorenz1(t,x,beta,rho,sigma)
     dx=[-beta*x(1)+x(2)*x(3);
         -rho*x(2)+rho*x(3); -x(1)*x(2)+sigma*x(2)-x(3)];
