  function more_vpasols(f,X0,varargin)
  [A,tlim]=default_vals({1000,60},varargin{:}); X=X0;
  if length(A)==1, a=-0.5*A; b=0.5*A; else, a=A(1); b=A(2); end
  ar=real(a); br=real(b); ai=imag(a); bi=imag(b); [i,n]=size(X0); tic
  while (1),
     x0=ar+(br-ar)*rand(1,n);
     if abs(imag(A))>1e-5, x0=x0+(ai+(bi-ai)*rand(1,n))*1i; end
     V=vpasolve(f,x0); N=size(X,1); key=1; x=sol2vec(V); 
     if length(x)>0
        t=toc; if t>tlim, break; end
        for j=1:N, if norm(X(j,:)-x)<1e-5; key=0; break; end, end
        if key>0, i=i+1;
           X=[X; x]; disp(['i=',int2str(i)]); assignin('base','X',X); tic 
  end, end, end
  function v=sol2vec(A)
  v=[]; A=struct2cell(A); for i=1:length(A), v=[v, A{i}]; end   