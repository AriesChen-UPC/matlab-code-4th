function varargout=default_vals(vals,varargin)
if nargout~=length(vals), error('number of arguments mismatch'); 
else, nn=length(varargin)+1;
    varargout=varargin; for i=nn:nargout, varargout{i}=vals{i};
end, end, end