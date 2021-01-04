function b=infc(c,x)
[pm,pn]=size(c);
x=cat(2,x,0);
b=[];
for i=1:pm
    if ismember(c(i,:),x)
        b=cat(2,b,c(i,:));
      end
end
%num
bb=unique(b);
b=setdiff(bb,0);