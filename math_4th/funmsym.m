   function F=funmsym(A,fun,x)
   [V,T]=jordan(A); vec=diag(T); v1=[0,diag(T,1)',0]; 
   v2=find(v1==0); lam=vec(v2(1:end-1)); m=length(lam); 
   for i=1:m,
      k=v2(i):v2(i+1)-1; J1=T(k,k); F(k,k)=funJ(J1,fun,x);
   end
   F=V*F*inv(V);
   function fJ=funJ(J,fun,x)
   lam=J(1,1); f1=fun; fJ=subs(fun,x,lam)*eye(size(J));
   H=diag(diag(J,1),1); H1=H;
   for i=2:length(J)
      f1=diff(f1,x); a1=subs(f1,x,lam); fJ=fJ+a1*H1; H1=H1*H/i;
   end
