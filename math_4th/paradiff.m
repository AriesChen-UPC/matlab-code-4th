   function result=paradiff(y,x,t,n)
   if mod(n,1)~=0, error('n should positive integer, please correct')
   else, if n==1, result=diff(y,t)/diff(x,t);
      else, result=diff(paradiff(y,x,t,n-1),t)/diff(x,t);
   end, end
 