     function A=any_real_matrix(n,varargin)
     [m,a_str]=default_vals({n,'a'},varargin{:});
     for i=1:n, for j=1:m, 
        str=[a_str int2str(i),int2str(j)]; eval(['syms ' str ' real']); 
        eval(['A(i,j)=' str ';']);
     end, end
