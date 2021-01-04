function y=redu(c,d,x)% 
y=core(c,d,x); q=ind(d,x); p=ind(c,x);
pos_cd=pospq(p,q); re=y; red=ind(y,x); pos_red=pospq(red,q);
while pos_cd~=pos_red
    cc=setdiff(c,re); [c1,c2]=size(cc);
    for i=1:c2, yy(i)=sgf(cc(i),re,d,x); end
    cd=setdiff(c,y); [d1,d2]=size(cd);
    for i=d2:-1:c2+1, yy(i)=[]; end
    [zz,ii]=sort(yy);
    for v1=c2:-1:1
        v2=ii(v1); re=cat(2,re,cc(v2)); red=ind(re,x); pos_red=pospq(red,q);
    end
end
[re1,re2]=size(re);
for qi=re2:-1:1
    if ismember(re(qi),core(c,d,x)), y=re; break; end
    re=setdiff(re,re(qi)); red=ind(re,x); pos_red=pospq(red,q);
    if pos_cd==pos_red, y=re; end
end
[y1,y2]=size(y); j=1; 
for i=1:y2, [y,j]=redu2(j,y,c,d,x); end

function [y,j]=redu2(i,re,c,d,x)%i index,re reduce 
yre=re; [re1,re2]=size(re); q=ind(d,x);
p=ind(c,x); pos_cd=pospq(p,q);
for qi=i:re2
    re=setdiff(re,re(qi)); red=ind(re,x); pos_red=pospq(red,q);
    if pos_cd==pos_red
        y=re; j=i; break
    else 
        y=yre; j=i+1; break
    end
end
