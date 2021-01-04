function [Y out]=outliers(X,method,alpha)

% Reports vector of observations Y which are not outliers and vector of
% observations out which are outliers according to either Grubbs' test or
% the Quartile method applied to initial vector of observations X
% 
% USAGE:    [Y out]=outliers(X,method,alpha)
% 
% INPUT:
% X         Nx1 vector of observations
% method    string (either 'grubbs' or 'quartile')
% alpha     significance level of Grubbs' test (alpha in [0,1]) or
%           range looseness parameter of Quartile method
% 
% OUTPUT:
% Y         (N-k)x1 vector of observations in X which are not outliers
% out       kx1 vector of observations in X which are outliers

% Author: Niccolo Battistini (Rutgers University)

if nargin~=3;
    error('Wrong # of arguments')
end

switch method
    
    % Grubbs' test
    
    case 'grubbs'
        z=1;
        test=false;
        while test==false;
            N=length(X);
            Xmean=repmat(mean(X),N,1); % N by 1 vector of mean of X
            Xstd=std(X); % standard deviation of X
            tcv=tinv((1-alpha)/(2*N),N-2); % t-stat critical value
            Gcv=((N-1)/sqrt(N))*sqrt(tcv^2/(N-2+tcv^2)); % G-stat CV
            [maxdev ind]=max(abs(X-Xmean));
            G=maxdev/Xstd; % G-stat
            if G>Gcv;
                out(z,1)=X(ind);
                X=X([1:N]~=ind);
                z=z+1;
                test=false;
            else
                test=true;
            end
        end
        if z==1;
            out=[];
        end
        Y=X;
    
    % Quartile method
    
    case 'quartile'
        Q1=prctile(X,25);
        Q3=prctile(X,76);
        rangedown=Q1-alpha*(Q3-Q1);
        rangeup=Q3+alpha*(Q3-Q1);
        Y=X(X>rangedown & X<rangeup);
        out=X(X<=rangedown | X>=rangeup);
end
end