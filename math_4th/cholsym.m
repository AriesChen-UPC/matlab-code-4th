function D=cholsym(A)
n=length(A); D(1,1)=sqrt(A(1,1)); D(1,2:n)=A(2:n,1)/D(1,1);
for i=2:n, k=1:i-1; D(i,i)=sqrt(A(i,i)-sum(D(k,i).^2));
   for j=i+1:n, D(i,j)=(A(j,i)-sum(D(k,j).*D(k,i)))/D(i,i); end
end
