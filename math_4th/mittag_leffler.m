   function f=mittag_leffler(aa,z)
   aa=[aa 1]; a=aa(1); b=aa(2); 
   syms k; f=simplify(symsum(z^k/gamma(a*k+b),k,0,inf));
