function F=mellin_trans(f,z,varargin)
f1=@(x)f(x).*x.^(z-1); % describing integrand for Mellin transform
F=integral(f1,0,Inf,'ArrayValued',true,varargin{:});