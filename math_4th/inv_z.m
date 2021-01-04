  function y=inv_z(num,den,varargin)
  [d,N]=default_vals({0,10},varargin{:}); num(N)=0;
  for i=1:N-d, k=num(1)/den(1); y(d+i)=k;
     if length(num)>1, ii=2:length(den);
        if length(den)>length(num); num(length(den))=0; end
        num(ii)=num(ii)-k*den(ii); num(1)=[];
  end, end
