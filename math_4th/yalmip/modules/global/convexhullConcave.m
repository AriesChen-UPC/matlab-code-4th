function [Ax,Ay,b] = convexhullConcave(xL,xU,fL,fU,dfL,dfU)
% Two lower bounds from tangents
% y < f(xL) + (x-xL)*df(xL)
% y < f(xU) + (x-xL)*df(xU)
% Upper bound from conneting extreme points
% y > f(xU)(x-xL)/(xU-xL) +  f(xL)(xU-x)/(xU-xL)
% can be wrtitten as
% Ax*x + Ay*y < b
if xL < xU   
    Ay = [1;
        1;
        -1];
    b = [fL - xL*dfL;
        fU - xU*dfU;
        fU*xL/(xU-xL) -  fL*xU/(xU-xL)];
    Ax = [-dfL;
        -dfU;
        fU/(xU-xL) - fL/(xU-xL)];
else
    Ax = [];
    Ay = [];
    b = [];
end