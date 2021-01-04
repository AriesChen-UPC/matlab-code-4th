 function w=rsupper(y,a,T)
 z=ind(a,T); w=[]; [p,q]=size(z);
 for u=1:p
    zz=setdiff(z(u,:),0); zzz=intersect(zz,y);
    [zp,zq]=size(zzz); if zq~=0, w=cat(2,w,zz); end
 end
