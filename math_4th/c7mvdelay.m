function y=c7mvdelay(u)
x1=u(1); x2=u(2); x3=u(3); d1=u(4); d2=u(5); t=u(6);
y=[-2*x2-3*d2; -0.05*x1*x3-2*d2; 0.3*x1*x2*x3+cos(x1*x2)+2*sin(0.1*t)];
