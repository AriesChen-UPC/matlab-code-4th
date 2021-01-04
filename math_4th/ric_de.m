     function dy=ric_de(t,x,A,B,C)
     P=reshape(x,size(A)); Y=A'*P+P*A+P*B*P+C; dy=Y(:);
