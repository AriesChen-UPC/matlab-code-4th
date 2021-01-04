     function B=polyvalmsym(p,A)
     E=eye(size(A)); B=zeros(size(A)); n=length(A);
     for i=n+1:-1:1, B=B+p(i)*E; E=E*A; end
