     function dy=caputo(y,t,gam,vec,L)
     t0=t(1); dy=glfdiff(y,t,gam); if nargin<=3, L=10; end
     if gam>0, m=ceil(gam); if gam<=1,vec=y(1); end
         for k=0:m-1, dy=dy-vec(k+1)*(t-t0).^(k-gam)./gamma(k+1-gam); end
         yy1=interp1(t(L+1:end),dy(L+1:end),t(1:L),'spline'); dy(1:L)=yy1;
     end