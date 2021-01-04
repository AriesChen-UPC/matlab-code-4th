function y=sam_del(x)%合并相同的行
y(1,:)=x(1,:); [n,p]=size(x); k=2;
for i=2:n
    num=0;
    for j=1:i-1
        s=x(i,:)==x(j,:); [u,v]=size(s); l=ones(u,v); s=s*l';
        if s==p, break; end
        num=num+1;
    end
    if num==i-1, y(k,:)=x(i,:); k=k+1; end
end
