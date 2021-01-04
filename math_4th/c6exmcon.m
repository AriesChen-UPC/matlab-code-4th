     function [c,ce]=c6exmcon(x)
     ce=[]; c=[x(1)+x(2); x(1)*x(2)-x(1)-x(2)+1.5; -10-x(1)*x(2)];
