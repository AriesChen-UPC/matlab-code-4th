function [x,f0]=fmincon_global(f,a,b,n,N,varargin)
x0=rand(n,1); k0=0; if strcmp(class(f),'struct'), k0=1; end %处理结构体
if k0==1, f.x0=x0; [x f0]=fmincon(f); %如果是结构体描述的问题，直接求解
else, [x f0]=fmincon(f,x0,varargin{:}); end %如果不是结构体描述的，直接求解
for i=1:N, x0=a+(b-a)*rand(n,1); %用循环结构尝试不同的随机搜索初值
   if k0==1, f.x0=x0; [x1 f1 key]=fmincon(f); %结构体问题求解
   else, [x1 f1 key]=fmincon(f,x0,varargin{:}); end %非结构体问题求解
   if key>0 & f1<f0, x=x1; f0=f1; end %如果找到的解优于现有的最好解，存储该解
end