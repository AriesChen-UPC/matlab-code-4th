function S=sylv_mat(A,B)
n=length(B)-1; m=length(A)-1; S=[]; % 由给定矩阵获得n与m
A1=[A(:); zeros(n-1,1)]; B1=[B(:); zeros(m-1,1)]; % 第1列与m + 1列
for i=1:n, S=[S A1]; A1=[0; A1(1:end-1)]; end % 按照（4.60）规则构造系数矩阵
for i=1:m, S=[S B1]; B1=[0; B1(1:end-1)]; end; S=S.'; % 转置后得到Sylvester矩阵