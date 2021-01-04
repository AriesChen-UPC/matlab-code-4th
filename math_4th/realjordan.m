function [V1,J]=realjordan(A)
[V,J]=jordan(A); n=length(V); i=0; vr=real(V); vi=imag(V); n1=n; k=[];
while(i<n1), i=i+1; V1(:,i)=vr(:,i), v=vi(:,i);
   if any(v~=0), k=[k,i+1]; for j=i+1:n, if all(vi(:,j)+v==0), V1(:,j)=v; n1=n1-1; 
end, end, end, end
E=eye(size(V)); E(:,k)=E(:,k(end:-1:1)); V1=V1*E; J=inv(V1)*J*V1;
