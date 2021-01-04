     function f=ml_func(aa,z,varargin)
     aa=[aa,1,1,1]; a=aa(1); b=aa(2); c=aa(3); q=aa(4); f=0; k=0; fa=1; 
     [n,eps0]=default_vals({0,eps},varargin{:});
     if n==0
        while norm(fa,1)>=eps0
           fa=gamma(k*q+c)/gamma(c)/gamma(k+1)/gamma(a*k+b) *z.^k;
           f=f+fa; k=k+1;
        end
        if ~isfinite(f(1))
           if c*q==1
              f=mlf(a,b,z,round(-log10(eps0))); f=reshape(f,size(z));
           else, error('Error: truncation method failed'); end, end
     else
        aa(2)=aa(2)+n*aa(1); aa(3)=aa(3)+aa(4)*n;
        f=gamma(q*n+c)/gamma(c)*ml_func(aa,z,0,eps0);
     end
