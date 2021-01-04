function key=isanumber(a)
key=0; if length(a)~=1, return; end 
switch class(a)
    case 'double', key=1;
    case 'sym', try, double(a); key=1; catch, end
end