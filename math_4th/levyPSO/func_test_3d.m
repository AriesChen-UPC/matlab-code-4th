function val = func_test_3d(arg)
x = arg(:,1);
y = arg(:,2);
z = arg(:,3);
val = 30+(x/30-1).^2+(y/20-1).^2+(z/40-1).^2 ...
    -10*(cos(pi*(x/30-1))+cos(pi*(y/20-1))+cos(pi*(z/40-1)));
