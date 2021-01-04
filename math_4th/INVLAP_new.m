function [t,y]=INVLAP_new(G,t0,tn,N,H,tx,ux)
% INVLAP_new - updated version of INVLAP for closed-loop system with any inputs
%
%   [t,y]=INVLAP_new(G,t0,tn,N)
%   [t,y]=INVLAP_new(G,t0,tn,N,H)
%   [t,y]=INVLAP_new(G,t0,tn,N,H,u)
%   [t,y]=INVLAP_new(G,t0,tn,N,H,tx,ux)
%
%   G - the string representation of the open-loop model
%   t0, tn, N - the time interval and number of points in the interval
%   H - the string representation of the feedback model
%   u - the function handle of the input signal
%   tx, ux - the samples of time and input signal
%   y, t - the output and time vectors
   
% Copyright (c) Dingyu Xue, Northeastern University, China
% Last modified 13 June, 2017 
G=add_dots(G); if nargin<=5, tx='1'; end, if nargin<=4, H=0; end
if ischar(H), H=add_dots(H); end
if ischar(tx), tx=add_dots(tx); end
a=6; ns=20; nd=19; t=linspace(t0,tn,N);
if t0==0, t=t(2:N); N=N-1; end, 
n=1:ns+1+nd; alfa=a+(n-1)*pi*j; bet=-exp(a)*(-1).^n;
n=1:nd; bet(1)=bet(1)/2;
bdif=fliplr(cumsum(gamma(nd+1)./gamma(nd+2-n)./gamma(n)))./2^nd;
bet(ns+2:ns+1+nd)=bet(ns+2:ns+1+nd).*bdif;
if isnumeric(H), H=num2str(H); end
for i=1:N
   tt=t(i); s=alfa/tt; bt=bet/tt; sG=eval(G); sH=eval(H);
   if ischar(tx), sU=eval(tx);
   else
      if isnumeric(tx),
         f=@(x)interp1(tx,ux,x,'spline').*exp(-s.*x);
      else, f=@(x)tx(x).*exp(-s.*x); end
      sU=integral(f,t0,tn,'ArrayValued',true);
   end
   btF=bt.*sG./(1+sG.*sH).*sU; y(i)=sum(real(btF));
end
% remove and add back dots uniformly
function F=add_dots(F)
F=strrep(strrep(strrep(F,'.*','*'),'./','/'),'.^','^');
F=strrep(strrep(strrep(F,'*','.*'),'/','./'),'^','.^');
