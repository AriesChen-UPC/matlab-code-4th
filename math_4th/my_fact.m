function k=my_fact(n)
if nargin~=1, error('Error: Only one input variable accepted'); end
if abs(n-floor(n))>eps | n<0 %判断n是否为非负整数，如果不是则给出错误信息
   error('n should be a non-negative integer'); %给出错误信息
end
if n>1, k=n*my_fact(n-1); %若n > 1，则采用递归调用
elseif any([0 1]==n), k=1; end %0! = 1! = 1，函数的出口