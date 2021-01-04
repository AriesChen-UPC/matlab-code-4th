function [cf,r]=puiseux(varargin)
switch length(varargin)
   case 1, cf=feval(symengine,'Series::Puiseux',varargin{1});
   case 2, cf=feval(symengine,'Series::Puiseux',varargin{1},varargin{2});
   case 3, cf=feval(symengine,'Series::Puiseux',varargin{1},varargin{2},varargin{3});
end
cf
if nargout==2, r=feval(symengine,'coeff',cf); end