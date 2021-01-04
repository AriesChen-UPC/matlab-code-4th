function I=path_integral(F,vars,t,a,b)
if length(F)==1, I=int(F*sqrt(sum(diff(vars,t).^2)),t,a,b);
else, F=F(:).'; vars=vars(:); I=int(F*diff(vars,t),t,a,b); end