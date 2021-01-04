function y=sgf(a,r,d,x)
pr=ind(r,x); q=ind(d,x); b=cat(2,r,a); pb=ind(b,x);
p1=pospq(pb,q); p2=pospq(pr,q); y=p1-p2;
