     function [c,ceq]=c6mmibp(x), ceq=[];
     c=[-0.8*log(x(2)+1)-0.96*log(x(1)-x(2)+1)+0.8*x(3);
        -log(x(2)+1)-1.2*log(x(1)-x(2)+1)+x(3)+2*x(6)-2];
