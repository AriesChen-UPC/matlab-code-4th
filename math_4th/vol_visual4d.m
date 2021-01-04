function varargout = vol_visual4d(varargin)
% VOL_VISUAL4D MATLAB code for vol_visual4d.fig
%      VOL_VISUAL4D, by itself, creates a new VOL_VISUAL4D or raises the existing
%      singleton*.
%
%      H = VOL_VISUAL4D returns the handle to a new VOL_VISUAL4D or the handle to
%      the existing singleton*.
%
%      VOL_VISUAL4D('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VOL_VISUAL4D.M with the given input arguments.
%
%      VOL_VISUAL4D('Property','Value',...) creates a new VOL_VISUAL4D or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vol_visual4d_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vol_visual4d_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vol_visual4d

% Last Modified by GUIDE v2.5 17-Jan-2013 13:25:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vol_visual4d_OpeningFcn, ...
                   'gui_OutputFcn',  @vol_visual4d_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function vol_visual4d_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
%if length(varargin)==4
   x=varargin{1}; y=varargin{2}; z=varargin{3}; V=varargin{4}; 
   x1=min(x(:)); x2=max(x(:)); y1=min(y(:)); y2=max(y(:)); z1=min(z(:)); z2=max(z(:)); 
   xv=[x1 (x1+x2)/2 x2]; yv=[y1 (y1+y2)/2 y2]; zv=[z1 (z1+z2)/2 z2];
   axes(handles.axMain); slice(x,y,z,V,xv(2:3),yv(2:3),zv(1:2))
   set(handles.axMain,'UserData',{x,y,z,V,xv,yv,zv});
   set(handles.sldX,'Min',x1,'Max',x2,'Value',(x1+x2)/2); 
   set(handles.edtX,'String',num2str((x1+x2)/2));
   set(handles.sldY,'Min',y1,'Max',y2,'Value',(y1+y2)/2);
   set(handles.edtY,'String',num2str((y1+y2)/2));
   set(handles.sldZ,'Min',z1,'Max',z2,'Value',(z1+z2)/2);
   set(handles.edtZ,'String',num2str((z1+z2)/2));
   shaded(handles); 
%end

function varargout = vol_visual4d_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function sldX_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function sldY_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function sldZ_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function lstShade_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edtZ_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edtY_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edtX_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sldX_Callback(hObject, eventdata, handles)
set_slidedata(1,handles);
function sldY_Callback(hObject, eventdata, handles)
set_slidedata(2,handles);
function sldZ_Callback(hObject, eventdata, handles)
set_slidedata(3,handles);
function lstShade_Callback(hObject, eventdata, handles)
shaded(handles); 
function chkX_Callback(hObject, eventdata, handles)
set_slidedata(4,handles)
function chkY_Callback(hObject, eventdata, handles)
set_slidedata(4,handles)
function chkZ_Callback(hObject, eventdata, handles)
set_slidedata(4,handles)
function edtX_Callback(hObject, eventdata, handles)
set_range(handles.edtX,handles.sldX,1,'x',handles);
function edtY_Callback(hObject, eventdata, handles)
set_range(handles.edtY,handles.sldY,2,'y',handles);
function edtZ_Callback(hObject, eventdata, handles)
set_range(handles.edtZ,handles.sldZ,3,'z',handles);

function set_slidedata(key,handles)
vars=get(handles.axMain,'UserData'); x=vars{1}; y=vars{2}; z=vars{3};
V=vars{4}; xv=vars{5}; yv=vars{6}; zv=vars{7}; 
switch key
    case 1, xv(2)=get(handles.sldX,'Value'); set(handles.edtX,'String',num2str(xv(2))) 
    case 2, yv(2)=get(handles.sldY,'Value'); set(handles.edtY,'String',num2str(yv(2))) 
    case 3, zv(2)=get(handles.sldZ,'Value'); set(handles.edtZ,'String',num2str(zv(2))) 
    case 4, 
end
redraw_slices(handles,x,y,z,V,xv,yv,zv);

function redraw_slices(handles,x,y,z,V,xv,yv,zv)
xvv=xv(2:3); yvv=yv(2:3); zvv=zv(1:2);
if get(handles.chkX,'Value')==0, xvv=xv(3); end
if get(handles.chkY,'Value')==0, yvv=yv(3); end
if get(handles.chkZ,'Value')==0, zvv=zv(1); end
axes(handles.axMain); slice(x,y,z,V,xvv,yvv,zvv)
set(handles.axMain,'UserData',{x,y,z,V,xv,yv,zv}); shaded(handles);

function shaded(handles) 
v=get(handles.lstShade,'Value'); axes(handles.axMain);
switch v
    case 1, shading faceted
    case 2, shading flat
    case 3, shading interp
end

function set_range(edt,sld,key,str,handles)
try
    v=eval(get(edt,'String')); v1=get(sld,'Min');  v2=get(sld,'Max');
    if (v>=v2), v=v2; elseif (v<=v1) v=v1; end, 
    set(sld,'Value',v); set(edt,'String',num2str(v)); set_slidedata(key,handles)
catch
    errordlg(['Error in the ' str ' edit box'])
end
