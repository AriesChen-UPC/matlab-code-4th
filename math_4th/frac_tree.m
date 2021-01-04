   function [x,y]=frac_tree(x0,y0,v)
   N=length(v); x=[x0; zeros(N-1,1)]; y=[y0; zeros(N-1,1)];
   for i=2:N, vv=v(i);
      if vv<0.05, y(i)=0.5*y(i-1);
      elseif vv<0.45, x(i)=0.42*(x(i-1)-y(i-1)); y(i)=0.2+0.42*(x(i-1)+y(i-1));
      elseif vv<0.85, x(i)=0.42*(x(i-1)+y(i-1)); y(i)=0.2-0.42*(x(i-1)-y(i-1));
      else, x(i)=0.1*x(i-1); y(i)=0.1*y(i-1)+0.2;
   end, end
