function H=hankel_trans(f,w,nu,varargin)
F=@(t)t.*f(t).*besselj(nu,w*t);         % describing the integrand of Hankel transform
H=integral(F,0,Inf,'ArrayValued',true,varargin{:}); % compute numerical Hankel transform
