function xx= rsdav3(varargin)
%function varargout = rsdav3(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rsdav3_OpeningFcn, ...
                   'gui_OutputFcn',  @rsdav3_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
   [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
   gui_mainfcn(gui_State, varargin{:});
end

function rsdav3_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = rsdav3_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
function btnBrowse_Callback(hObject, eventdata, handles)
try
    [filename, pathname]=uigetfile('*.txt;*.dat', 'Open data file');
    eval(['X=load(''' pathname filename ''');'])
    [nX,nY]=size(X);
    set(handles.txtSizeData,'String',['Decision Table of ' int2str(nX) 'x' int2str(nY)]);
    set(handles.edtC,'String',['1:' int2str(nY-1)])
    set(handles.edtD,'String',int2str(nY));
    set(handles.btnBrowse,'UserData',X);
catch
    errordlg('Error in Data file')
end


function Y_Callback(hObject, eventdata, handles)
pin=str2num(get(handles.Y,'string')); ha=findobj('Tag','Y');
set(ha,'userdata',pin);

function core_Callback(hObject, eventdata, handles)
[bb,dd,xx]=getdata(handles); 
x=core(bb,dd,xx); 
set(handles.edtOut,'String',num2str(x));

function clear_Callback(hObject, eventdata, handles)
set(handles.edtOut,'String','');

function quit_Callback(hObject, eventdata, handles)
close(gcf);

function about_Callback(hObject, eventdata, handles)
rs_about;

function indp_Callback(hObject, eventdata, handles)
[bb,dd,xx]=getdata(handles); 
R=str2num(get(handles.edtR,'String'));
yy=ind(R,xx); 
set(handles.edtOut,'string',num2str(yy))

function RYlower_Callback(hObject, eventdata, handles)
indp_r=eval(get(handles.edtR,'String'));
Ry_y=eval(get(handles.edtY,'String'));
[bb,dd,xx]=getdata(handles); 
yy=rslower(Ry_y,indp_r,xx);
set(handles.edtOut,'string',num2str(yy))

function RYupper_Callback(hObject, eventdata, handles)
indp_r=eval(get(handles.edtR,'String'));
Ry_y=eval(get(handles.edtY,'String'));
[bb,dd,xx]=getdata(handles); 
yy=rsupper(Ry_y,indp_r,xx);
set(handles.edtOut,'string',num2str(yy))

function SGF_Callback(hObject, eventdata, handles)
sgf_a=eval(get(handles.edtA,'String'));
sgf_r=eval(get(handles.edtR,'String'));
sgf_d=eval(get(handles.edtD,'String'));
[bb,dd,xx]=getdata(handles); 
yy=sgf(sgf_a,sgf_r,sgf_d,xx);
set(handles.edtOut,'string',num2str(yy))

% --- Executes on button press in POSCD.
function POSCD_Callback(hObject, eventdata, handles)
[bb,dd,xx]=getdata(handles); 
x=posind(bb,dd,xx); 
set(handles.edtOut,'string',['The rate of pos(C,D) is ',num2str(x)])

function redP_Callback(hObject, eventdata, handles)
[bb,dd,xx]=getdata(handles); 
x=redu(bb,dd,xx);
set(handles.edtOut,'String',num2str(x));

% --- Executes on button press in Valuereduce.
function Valuereduce_Callback(hObject, eventdata, handles)
val_r=eval(get(handles.edtR,'String'));
val_d=eval(get(handles.edtD,'String'));
[bb,dd,xx]=getdata(handles); 
val_rc=num2str(val_r); val_dc=num2str(val_d);
yy=val_redu(val_r,val_d,xx); yy=num2str(yy);
ss=strcat('   C  =  :',val_rc,'        and D =  :',val_dc);
yy=strvcat(ss,yy); set(handles.edtOut,'string',yy)

function XR_Callback(hObject, eventdata, handles)
xr_a=eval(get(handles.edtA,'String'));
xr_r=eval(get(handles.edtR,'String'));
[bb,dd,xx]=getdata(handles); 
yy=ind_cls(xr_a,xr_r,xx); yy=num2str(yy);
yy=strcat('If A= ',num2str(xr_a),', the [X]R is {',yy,'}');
set(handles.edtOut,'string',yy)

function matrix_Callback(hObject, eventdata, handles)
[pos_c,pos_d,xx]=getdata(handles); 
set(handles.edtOut,'string',num2str(xx))

function order_Callback(hObject, eventdata, handles)
[pos_c,pos_d,xx]=getdata(handles); 
yz=order(pos_c,pos_d,xx);
set(handles.edtOut,'string',num2str(yz))

function [C,D,X]=getdata(handles)
C=eval(get(handles.edtC,'String'));
D=eval(get(handles.edtD,'String'));
X=get(handles.btnBrowse,'UserData');

function order_CreateFcn(hObject, eventdata, handles)
function clear_CreateFcn(hObject, eventdata, handles)
%common_init_fcn(hObject, eventdata, handles)
function quit_CreateFcn(hObject, eventdata, handles)
%common_init_fcn(hObject, eventdata, handles)
function VAluereduce_CreateFcn(hObject, eventdata, handles)
%common_init_fcn(hObject, eventdata, handles)
function XR_CreateFcn(hObject, eventdata, handles)
common_init_fcn(hObject, eventdata, handles)
function edtOut_CreateFcn(hObject, eventdata, handles)
common_init_fcn(hObject, eventdata, handles)
function about_CreateFcn(hObject, eventdata, handles)
common_init_fcn(hObject, eventdata, handles)
function indp_CreateFcn(hObject, eventdata, handles)
common_init_fcn(hObject, eventdata, handles)
function btnBrowse_CreateFcn(hObject, eventdata, handles)
common_init_fcn(hObject, eventdata, handles)
function POSCD_CreateFcn(hObject, eventdata, handles)
common_init_fcn(hObject, eventdata, handles)
function edtD_CreateFcn(hObject, eventdata, handles)
common_init_fcn(hObject, eventdata, handles)
function edtC_CreateFcn(hObject, eventdata, handles)
common_init_fcn(hObject, eventdata, handles)
function core_CreateFcn(hObject, eventdata, handles)
common_init_fcn(hObject, eventdata, handles)
function Rylower_CreateFcn(hObject, eventdata, handles)
common_init_fcn(hObject, eventdata, handles)
function RYupper_CreateFcn(hObject, eventdata, handles)
common_init_fcn(hObject, eventdata, handles)
function redP_CreateFcn(hObject, eventdata, handles)
common_init_fcn(hObject, eventdata, handles)
function SGF_CreateFcn(hObject, eventdata, handles)
common_init_fcn(hObject, eventdata, handles)
function edtA_CreateFcn(hObject, eventdata, handles)
common_init_fcn(hObject, eventdata, handles)
function edtR_CreateFcn(hObject, eventdata, handles)
common_init_fcn(hObject, eventdata, handles)
function edtY_CreateFcn(hObject, eventdata, handles)
common_init_fcn(hObject, eventdata, handles)

function edtA_Callback(hObject, eventdata, handles)
function edtY_Callback(hObject, eventdata, handles)
function edtR_Callback(hObject, eventdata, handles)
function help_Callback(hObject, eventdata, handles)
function edtOut_Callback(hObject, eventdata, handles)

function common_init_fcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
