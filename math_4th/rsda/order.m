function y=order(c,d,x)
[p,q]=size(x); [cp,cq]=size(c); yy=zeros(size(c));
for u=1:cq, yy(u)=pospq(ind(u,x),ind(d,x)); end
[yy,i]=sort(yy,2); y=[i;yy];


