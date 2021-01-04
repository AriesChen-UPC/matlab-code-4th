   function dy=impldiff(f,x,y,n)
   if mod(n,1)~=0, error('n should positive integer, please correct')
   else, F1=-simplify(diff(f,x)/diff(f,y)); dy=F1;
      for i=2:n, dy=simplify(diff(dy,x)+diff(dy,y)*F1); 
   end, end   
