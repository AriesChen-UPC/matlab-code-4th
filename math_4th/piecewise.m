    function f=piecewise(varargin), str=[]; 
    try
       for i=1:2:length(varargin), 
          str=[str,'[',varargin{i},',',varargin{i+1},'],'];
       end
    catch, error('Input arguments should be given in pairs.'), end
    f=feval(symengine,'piecewise',str(1:end-1));
