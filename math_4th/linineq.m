     function b0=linineq(A,b)
     for i=1:length(b), s=0;
        for j=1:length(b)
           B=A; B(j,:)=[]; B(:,i)=[]; s=s+b(j)*abs(det(B));
        end, b0(i,1)=s/abs(det(A));
     end
