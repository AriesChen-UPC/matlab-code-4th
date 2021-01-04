   function [R,P,K]=pfrac(num,den)
   [R,P,K]=residue(num,den);
   for i=1:length(R),
      if imag(P(i))>eps, a=real(R(i)); b=imag(R(i));
         R(i)=-2*sqrt(a^2+b^2); R(i+1)=-atan2(a,b);
      elseif abs(imag(P(i)))<eps, R(i)=real(R(i));
   end, end
