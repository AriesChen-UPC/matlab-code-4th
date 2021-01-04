function a=my_fibo(k) %递归调用格式编写的函数
if k==1 | k==2, a=1; else, a=my_fibo(k-1)+my_fibo(k-2); end
