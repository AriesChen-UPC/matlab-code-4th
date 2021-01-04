     function [x1,y1,z1,v1]=mesh2nd(x,y,z,v)
     switch nargin
        case 3, x1=x.'; y1=y.'; z1=z.'
        case 4, z1=z; 
           for i=1:size(x,3), 
              x1(:,:,i)=x(:,:,i).'; y1(:,:,i)=y(:,:,i).'; v1(:,:,i)=v(:,:,i).'; 
           end
         otherwise, error('Error in input arguments')
     end       
