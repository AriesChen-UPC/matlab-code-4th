 function w=rslower(y,a,T)
 z=ind(a,T); w=[]; [p,q]=size(z);  
 for u=1:p, 
    zz=setdiff(z(u,:),0); if ismember(zz,y), w=cat(2,w,zz); end, 
 end
