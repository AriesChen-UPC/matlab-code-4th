function [cf,r]=contfrac(f,varargin)
[n,a]=default_vals({6,0},varargin{:});
if isanumber(f), cf=feval(symengine,'contfrac',f,n);
    p1=char(cf); k=strfind(p1,','); k1=strfind(p1,'/');
    if nargout>1, r=sym(p1(k(end)+1:k1-1))/sym(p1(k1+1:end-1)); end
else, if isfinite(a), str=num2str(a); else, str='infinity'; end
    cf=feval(symengine,'contfrac',f,['x=' str],n);
    if nargout>1, r=feval(symengine,'contfrac::rational',cf); end
end
