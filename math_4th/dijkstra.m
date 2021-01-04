function [d,path]=dijkstra(W,s,t)
[n,m]=size(W); ix=(W==0); W(ix)=Inf;
if n~=m, error('Square W required'); end
visited(1:n)=0; dist(1:n)=Inf; parent(1:n)=0; dist(s)=0; d=Inf;
for i=1:(n-1), 
   ix=(visited==0); vec(1:n)=Inf; vec(ix)=dist(ix); [a,u]=min(vec); visited(u)=1;
   for v=1:n, if (W(u,v)+dist(u)<dist(v)), dist(v)=dist(u)+W(u,v); parent(v)=u;
end; end; end
if parent(t)~=0, path=t; d=dist(t);
   while t~=s, p=parent(t); path=[p path]; t=p; end
end