function A=any_matrix(nn,sA,varargin) %生成任意矩阵
v=varargin; n=nn(1); if length(nn)==1, m=n; else, m=nn(2); end
s=''; k=length(v); K=0; if n==1 | m==1, K=1; end
if k>0, s='('; for i=1:k, s=[s ',' char(v{i})]; end, s(2)=[]; s=[s ')']; end
for i=1:n, for j=1:m, %用循环结构逐个元素单独处理
if K==0, str=[sA int2str(i),int2str(j) s]; else, str=[sA int2str(i*j) s]; end
eval(['syms ' str]); eval(['A(i,j)=' str ';']); %指定相应的矩阵元素
end, end
