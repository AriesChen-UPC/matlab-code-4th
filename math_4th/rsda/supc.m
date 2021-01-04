function b=supc(c,x)
[pm,pn]=size(c); b=[]; d=[0];
for i=1:pm
    [q,w]=size(intersect(c(i,:),x));
    if w~=0, b=cat(2,b,c(i,:)); end
end
bb=unique(b); b=setdiff(bb,0);