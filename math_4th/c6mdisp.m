  function [c,ceq]=c6mdisp(y), ceq=[];
  c=[y(1)^2/10-6*y(1)/4+y(2)/10-11;
     -y(1)*y(2)/40+3*y(2)/10+exp(y(1)/4-3)-1];
