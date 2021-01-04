function P = charpoly(A,varargin)
%CHARPOLY   Characteristic polynomial of a matrix. 
%   P = CHARPOLY(A) returns the coefficients of the characteristic 
%   polynomial of the matrix A. If A is a SYM object, the vector returned
%   is a SYM object, too. Otherwise a vector with doubles is returned.  
% 
%   P = CHARPOLY(A,x) returns the characteristic polynomial of the matrix 
%   A in terms of the variable x. Here x must be a free symbolic variable.  
%
%   Examples:
%       syms x; 
%       A = sym([1 1 0; 0 1 0; 0 0 1]);
%
%       P = charpoly(A)
%       returns  [ 1, -3, 3, -1]
% 
%       P = sym2poly(charpoly(A,x))
%       returns    1    -3     3    -1
%
%       P = charpoly(A,x)
%       returns  x^3 - 3*x^2 + 3*x - 1
%
%       P = poly2sym(charpoly(A),x)
%       returns  x^3 - 3*x^2 + 3*x - 1 
%
%   See also MINPOLY, SYM/POLY2SYM, SYM/SYM2POLY, SYM/JORDAN, SYM/EIG, 
%   SOLVE.

%   Copyright 2012 The Mathworks, Inc. 

p = inputParser;

p.addRequired('A', @(x) ~isempty(x) && isa(sym(x),'sym')); 
p.addOptional('x', sym([]), @(x) isa(sym(x),'sym'));  

p.parse(A,varargin{:});

A = p.Results.A;
x = p.Results.x;

if ~isa(A,'sym') 
    Asym = sym(A);
else
    Asym = A;
end;

if ~isa(x,'sym'), x = sym(x); end

if builtin('numel',Asym) ~= 1,  Asym = normalizesym(Asym);  end
if builtin('numel',x) ~= 1,  x = normalizesym(x);  end

if isempty(x) 
    P = privUnaryOp(Asym,'symobj::charpoly');                        
    if ~isa(A,'sym') 
        P = double(P);
    end        
else 
    P = privBinaryOp(Asym,x,'symobj::charpoly');                    
end