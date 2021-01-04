function I=surf_integral(f,xx,uu,um,vm)
if length(f)==1 % scalar integrand
   if length(xx)==1 % surface described by an explicit function
      I=int(int(f*sqrt(1+diff(xx,uu(1))^2+diff(xx,uu(2))^2),...
            uu(2),um(1),um(2)),uu(1),vm(1),vm(2));
   else   % surface described by an implicit function
      xx=[xx(:).' 1]; x=xx(1); y=xx(2); z=xx(3); u=uu(1); v=uu(2);
      E=diff(x,u)^2+diff(y,u)^2+diff(z,u)^2;
      F=diff(x,u)*diff(x,v)+diff(y,u)*diff(y,v)+diff(z,u)*diff(z,v);
      G=diff(x,v)^2+diff(y,v)^2+diff(z,v)^2;
      I=int(int(f*sqrt(E*G-F^2),u,um(1),um(2)),v,vm(1),vm(2));
   end
else % vector integrand
   if length(xx)==1 % surface described by an explicit function
      syms x y z; ua=sqrt(1+diff(xx,x)^2+diff(xx,y)^2);
      cA=-diff(xx,x)/ua; cB=-diff(xx,y)/ua; cC=1/ua;
      I=surf_integral(f(:).'*[cA; cB; cC],xx,uu,um,vm);
   else, x=xx(1); y=xx(2); z=xx(3); u=uu(1); v=uu(2);
      A=diff(y,u)*diff(z,v)-diff(z,u)*diff(y,v);
      B=diff(z,u)*diff(x,v)-diff(x,u)*diff(z,v);
      C=diff(x,u)*diff(y,v)-diff(y,u)*diff(x,v); F=A*f(1)+B*f(2)+C*f(3);
      I=int(int(F,uu(1),um(1),um(2)),uu(2),vm(1),vm(2));
end, end
