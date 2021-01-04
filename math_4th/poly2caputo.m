function s=poly2caputo(a,r), syms u tau; 
if r==ceil(r), s=diff(poly2sym(a,u),r); 
else, s=int(diff(poly2sym(a,'tau'),ceil(r))/((u-tau)^(r-ceil(r)+1))...
                  /gamma(ceil(r)-r),tau,0,u);
end