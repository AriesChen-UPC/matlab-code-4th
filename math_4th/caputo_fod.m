     function dy=caputo(y,t,gam,vec)
     t0=t(1); dy=glfdiff(y,t,gam); 
     if gam>0, m=ceil(gam); if gam<=1,vec=y(1); end
         for k=0:m-1, dy=dy-vec(l+k)*(t-t0).^(k-gam)./gamma(k+1-gam);
     end, end