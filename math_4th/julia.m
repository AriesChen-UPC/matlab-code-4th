function W=julia(X,Y,c,n_iter)
%JULIA 为计算 Julia 集的函数。
%
%   W=julia(X,Y,c,n_iter)
%
%  X, Y 为用户选择的网格点坐标，c 为数学描述中的 c 点值，
%  n_iter为最大迭代次数，返回的 W 为 Julia 集的测度矩阵。

%Designed by Prof D Xue (c) 2000
Z=X+i*Y;
for k=1:n_iter, Z=Z.^2+c; end
W=exp(-abs(Z));
