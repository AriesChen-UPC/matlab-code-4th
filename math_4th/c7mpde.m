function [c,f,s]=c7mpde(x,t,u,du)
c=[1; 1]; y=u(1)-u(2); F=exp(5.73*y)-exp(-11.46*y); s=[-F; F];
f=[0.024*du(1); 0.17*du(2)];