  function [Pxx,f]=psd_estm(y,m,T,a)
  if nargin==3, a=0.54; end
  k=[0:m-1]; Y=zeros(1,m); m2=floor(m/2); f=k(1:m2)*2*pi/(length(k)*T);
  w=a-(1-a)*cos(2*pi*k/(m-1)); K=floor(length(y)/m); U=sum(w.^2)/m;
  for i=1:K, xi=y((i-1)*m+k+1)'; Xi=fft(xi.*w); Y=Y+abs(Xi).^2; end
  Pxx=Y(1:m2)*T/(K*m*U);
