   function [L,U]=lusym(A)
   n=length(A); U=sym(zeros(size(A))); L=sym(eye(size(A)));
   U(1,:)=A(1,:); L(:,1)=A(:,1)/U(1,1);
   for i=2:n,
      for j=2:i-1, L(i,j)=(A(i,j)-L(i,1:j-1)*U(1:j-1,j))/U(j,j); end
      for j=i:n, U(i,j)=A(i,j)-L(i,1:i-1)*U(1:i-1,j); end
   end
