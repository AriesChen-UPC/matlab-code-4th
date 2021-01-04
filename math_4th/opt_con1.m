     function [c,ceq]=opt_con1(x)
     ceq=[x(1)*x(1)+x(2)*x(2)+x(3)*x(3)-25; 8*x(1)+14*x(2)+7*x(3)-56]; c=[];
