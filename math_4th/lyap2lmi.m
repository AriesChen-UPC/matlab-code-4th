function F=lyap2lmi(A0)
if prod(size(A0))==1, n=A0; A=sym('a%d%d',n); else, n=size(A0,1); A=A0; end
vec=0; for i=1:n, vec(i+1)=vec(i)+n-i+1; end
for k=1:n*(n+1)/2,
   X=zeros(n); i=find(vec>=k); i=i(1)-1; j=i+k-vec(i)-1;
   X(i,j)=1; X(j,i)=1; F(:,:,k)=A.'*X+X*A;
end