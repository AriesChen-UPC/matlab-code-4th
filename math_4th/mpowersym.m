   function F=mpowersym(A,k)
   A=sym(A); [V,T]=jordan(A); vec=diag(T); v1=[0,diag(T,1)',0]; 
   v2=find(v1==0); lam=vec(v2(1:end-1)); m=length(lam); 
   for i=1:m,
      k0=v2(i):v2(i+1)-1; J1=T(k0,k0); F(k0,k0)=powJ(J1,k); 
   end
   F=simplify(V*F*inv(V));
   function fJ=powJ(J,k)
   lam=J(1,1); I=eye(size(J)); H=J-lam*I; fJ=lam^k*I; H1=k*H; 
   for i=2:length(J),
      fJ=fJ+lam^(k+1-i)*I*H1; H1=H1*H*(k+1-i)/i;
   end
