function [V,J]=jordan_real(A)
[V,J]=jordan(A); n=length(V); i=0; vr=real(V); vi=imag(V); n1=n; k=[];
while(i<n1), i=i+1; V(:,i)=vr(:,i); v=vi(:,i);
   if any(v~=0), k=[k,i+1]; for j=i+1:n, if all(vi(:,j)+v==0), V(:,j)=v; n1=n1-1; 
end, end, end, end
E=eye(size(V)); E(:,k)=E(:,k(end:-1:1)); V=V*E; J=inv(V)*A*V;
