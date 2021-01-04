function C=kronsum(A,B)
[ma,na]=size(A); [mb,nb]=size(B);
A=reshape(A,[1 ma 1 na]); B=reshape(B,[mb 1 nb 1]);
C=reshape(bsxfun(@plus,A,B),[ma*mb na*nb]);
