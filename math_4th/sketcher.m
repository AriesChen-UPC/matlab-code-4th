function sketcher(vis)
x=[]; y=[]; i=1; h=[]; axes(gca); 
while 1, [x0,y0,but]=ginput(1); 
   if but==1, x=[x,x0]; y=[y,y0]; 
      h(i)=line(x0,y0); set(h(i),'Marker','o'); i=i+1; else, break 
end, end
if nargin==1, delete(h); end 
[x ii]=sort(x); y=y(ii);
xx=[x(1):(x(end)-x(1))/100: x(end)]; 
yy=interp1(x,y,xx,'spline'); line(xx,yy) 
