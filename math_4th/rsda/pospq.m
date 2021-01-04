function [y,b]=pospq(p,q)
[pm,pn]=size(p); [qm,qn]=size(q); q1=zeros(qm,1);
q=cat(2,q,q1); num=0; b=[];
for i=1:pm, pp{i}=unique(p(i,:)); end
for j=1:qm, qq{j}=unique(q(j,:)); end
for i=1:qm
    for j=1:pm
      if ismember(pp{j},qq{i}), num=num+1; b=cat(2,b,pp{j}); end
  end
end
bb=unique(b); [cc,dd]=size(bb);
if ismember(0,bb)
    y=(dd-1)/pn;
else
    y=dd/pn;
end
b=setdiff(bb,0);


