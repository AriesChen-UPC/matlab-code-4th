  function [x,f0]=fminunc_global(f,a,b,n,N,varargin)
  x0=rand(n,1); k0=0; f0=Inf; if strcmp(class(f),'struct'), k0=1; end
  for i=1:N, x0=a+(b-a)*rand(n,1); 
     if k0==1, f.x0=x0; [x1 f1 key]=fminunc(f);
     else, [x1 f1 key]=fminunc(f,x0,varargin{:}); end
     if key>0 & f1<f0, x=x1; f0=f1; end
  end
