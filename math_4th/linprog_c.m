     function [x,f,flag,cc]=linprog_c(C,varargin)
     [p,m]=size(C); c=0;
     for i=1:p, 
         [x,f]=linprog(C(i,:),varargin{:}); c=c-C(i,:)/f; 
     end
     [x,f,flag,cc]=linprog(c,varargin{:});
