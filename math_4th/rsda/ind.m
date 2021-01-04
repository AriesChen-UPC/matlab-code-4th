 function aa=ind(a,x)
 [p,q]=size(x); [ap,aq]=size(a); z=1:q; 
 tt=setdiff(z,a); x(:,tt(size(tt,2):-1:1))=-1;
 for r=q:-1:1, if x(1,r)==-1, x(:,r)=[]; end, end
 for i=1:p, v(i)=x(i,:)*10.^(aq-[1:aq]'); end
 y=v'; [yy,I]=sort(y); y=[yy I];
 [b,k,l]=unique(yy); y=[l I]; m=max(l); aa=zeros(m,p);
 for ii=1:m, for j=1:p, if l(j)==ii, aa(ii,j)=I(j); end, end, end
