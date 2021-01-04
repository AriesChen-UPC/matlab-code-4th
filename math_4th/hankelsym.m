   function H=hankelsym(c,r)
   c=c(:); nc=length(c); if nargin==1, r=zeros(size(c)); end
   r=r(:); nr = length(r); x=[c; r((2:nr)')]; cidx=(1:nc)';
   ridx=0:(nr-1); H1=cidx(:,ones(nr,1))+ridx(ones(nc,1),:); H=x(H1);
