function y=ind_cls(va,p,x)
[pp,qq]=size(x); y=[];
for i=1:pp
    if x(i,p)==va, y=cat(2,y,i); end
end