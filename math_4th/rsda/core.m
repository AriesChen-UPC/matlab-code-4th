function y=core(c,d,x)
[xp,xq]=size(x); [cp,cq]=size(c); [dp,dq]=size(d);
y=[]; q=ind(d,x); pp=ind(c,x); [b,w]=pospq(pp,q);
for u=1:cq
    a{u}=setdiff(c,u); p{u}=ind(a{u},x); [k{u},kk{u}]=pospq(p{u},q);
    if k{u}~=b, y=cat(2,y,u); end
end
