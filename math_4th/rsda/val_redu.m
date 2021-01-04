function y=val_redu(re,d,x)
[p,q]=size(x); yy=[re,d]; zz=[1:q];
zy=setdiff(zz,yy); [zy1,zy2]=size(zy);
for u=q:-1:1
    for v=zy2:-1:1
        if zy(v)==u, x(:,u)=[]; end
    end
end
y=x; tmp=y; [yp,yq]=size(y); [dp,dq]=size(d);
%z=zeros(size(y)); z=ones(yp,yq-dq)*(-1);
for i=1:yp
    for j=1:yq-dq
        tmp(:,j)=[]; [tp,tq]=size(tmp);
        for ii=1:yp
            if ii==i, a=0;
            elseif tmp(ii,1:tq-dq)==tmp(i,1:tq-dq)&tmp(ii,tq-dq+1:tq)~=tmp(i,tq-dq+1:tq)
                z(i,j)=y(i,j);
            elseif tmp(ii,:)==tmp(i,:)
                y(i,j)=inf; z(i,j)=y(i,j);
            end
        end
        tmp=x;
    end
end
num=zeros(1,yp);
for i=1:yp
    for j=1:yq-dq
        if z(i,j)==-1, y(i,j)=-1; z(i,j)=inf; end
    end
end
for i=1:yp
    for j=1:yq-dq
        if z(i,j)==inf, num(1,i)=num(1,i)+1; end
    end
end
for i=1:yp
    if num(1,i)==yq-dq;
        for j=1:yq-dq
            if y(i,j)==-1, y(i,j)=x(i,j); end
        end
    end
end
for i=1:yp
    omit{i}=[];
    for j=1:yq-dq
        if y(i,j)==-1
            for jj=1:yq-dq
                if z(i,jj)~=inf, omit{i}=cat(2,omit{i},jj); end
            end
            tt=omit{i}; hhh=y(i,omit{i}); ddd=y(i,yq-dq+1:yq);
            if ismember(ind_cls(hhh,omit{i},x),ind_cls(ddd,yq-dq+1:yq,x))
                y(i,j)=inf;
            else
                y(i,j)=x(i,j);
            end
        end
    end
end
for i=yp:-1:1
    if y(i,1:yq-dq)==inf*ones(size( y(i,1:yq-dq)))
        y(i,:)=[];
    end
end
y=sam_del(y);