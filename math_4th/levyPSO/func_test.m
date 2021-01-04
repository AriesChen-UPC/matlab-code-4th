function val = func_test(arg)
x = arg(:,1);
y = arg(:,2);
val = 20+(x/30-1).^2+(y/20-1).^2-10*(cos(pi*(x/30-1))+cos(pi*(y/20-1)));
