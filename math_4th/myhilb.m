 function A=myhilb(n, m)
 %MYHILB  The function is used to illustrate MATLAB functions.
 %   A=MYHILB(N, M) generates an NxM Hilbert matrix A;
 %   A=MYHILB(N) generate and NxN square Hilbert matrix A;
 %
 %See also: HILB.

 %  Designed by Professor Dingyu XUE, Northeastern University, PRC
 %     5 April, 1995, Last modified by DYX at 30 July, 2001
 if nargout>1, error('Too many output arguments.'); end
 if nargin==1, m=n;   % if one input argument used, square matrix
 elseif nargin==0 | nargin>2
    error('Wrong number of input or output arguments.');
 end
 %for i=1:n, for j=1:m, A(i,j)=1/(i+j-1); end, end
 [i,j]=meshgrid(1:m,1:n); A=1./(i+j-1);
