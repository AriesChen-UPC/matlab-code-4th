     function dx=switch_sys(t,x)
     if x(1)*x(2)<0, A=[0.1 -1; 2 0.1]; else, A=[0.1 -2; 1 0.1]; end, dx=A*x;
