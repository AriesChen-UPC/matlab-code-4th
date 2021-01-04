   function more_sols(f,X0,varargin)
   [A,tol,tlim]=default_vals({1000,eps,30},varargin{:}); [n,m,i]=size(X0);
   if length(A)==1, a=-0.5*A; b=0.5*A; else, a=A(1); b=A(2); end
   ar=real(a); br=real(b); ai=imag(a); bi=imag(b);
   ff=optimset; ff.Display='off'; ff1=ff; ff.TolX=tol; ff.TolFun=tol; X=X0; 
   try, err=evalin('base','err'); catch, err=0; end, if i<=1; err=0; end, tic
   while (1)
      x0=ar+(br-ar)*rand(n,m);
      if abs(imag(A))>1e-5, x0=x0+(ai+(bi-ai)*rand(n,m))*1i; end
      [x,aa,key]=fsolve(f,x0,ff1);
      t=toc; if t>tlim, break; end
      if key>0, N=size(X,3);
         for j=1:N, if norm(X(:,:,j)-x)<1e-5; key=0; break; end, end
         if key>0, [x1,aa,key]=fsolve(f,x,ff);
            if norm(x-x1)<1e-5 & key>0; X(:,:,i+1)=x1; assignin('base','X',X); 
               err=max([norm(aa),err]); assignin('base','err',err); i=i+1, tic
   end, end, end, end
