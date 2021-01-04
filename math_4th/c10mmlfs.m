function y = c8mmlfs(u)
y = u^0.1*exp(u)*ml_func([1,1.545],-u)./ml_func([1,1.445],-u);
