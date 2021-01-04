     function [F,G,D,C]=sc2d(G,sig,T)
     G=ss(G); G=balreal(G); Gd=c2d(G,T); A=G.a; B=G.b; C=G.c; i=1;
     F=Gd.a; G=Gd.b; V0=B*sig*B'*T; Vd=V0; V1=Vd;
     while (norm(V1)<eps)
        V1=T/(i+1)*(A*V0+V0*A'); Vd=Vd+V1; V0=V1; i=i+1;
     end
     [U,S,V0]=svd(Vd); V0=sqrt(diag(S)); Vd=diag(V0); D=U*Vd;
