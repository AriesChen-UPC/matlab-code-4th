  function [F0,p,m,F]=laurent_series(f,n), [p,m]=poles(f);
  STR=''; if nargin==1, n=6; end
  syms z x; assume(z~=0); assume(x~=0); F2=0;
  if length(p)==0, error('The poles cannot be found, failed.'); end
  v=sort(unique([sym(0); abs(p)])); v0=[v; inf];
  Fx=feval(symengine,'partfrac',f,'List');
  nv=Fx(1); dv=Fx(2); f=feval(symengine,'partfrac',f); 
  for i=1:length(v), F1=f-F2;
     f1=taylor(F1,'Order',n); f2=subs(F2,z,1/x);
     f2=taylor(f2,'Order',n); f2=subs(f2,x,1/z); F(i)=f1+f2;
     v1=[char(v(i)) '<abs(z)']; F2=0;
     if i==length(v), str1=v1;
     else, str1=[v1 ' and abs(z)<' char(v(i+1))]; end
     str2=char(F(i)); STR=[STR, '''' str1 ''',''' str2 ''','];
     for j=1:length(nv), x0=solve(dv(j)); x0=x0(1);
        if abs(x0)<v0(i+1)+eps, F2=F2+nv(j)/dv(j); end
  end, end
  F0=eval(['piecewise(' STR(1:end-1) ');'])
