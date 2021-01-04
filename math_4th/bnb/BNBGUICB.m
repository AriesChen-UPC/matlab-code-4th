function BNBGUICB(action,file);
% BNBGUICB Callback function for BNBGUI 2.0.
% Do not run this file from the Matlab prompt.
persistent data;
persistent handles;

if nargin<1, ; action=''; end;

switch action
  
case('init')
   mlock;
   data.id='BNBGUI20 BNB20';
   data.fun='';
   data.xtag={[]};
   data.x0=[];
   data.xstatus=[];
   data.xlb=[];
   data.xub=[];
   data.A=[];
   data.B=[];
   data.Aeq=[];
   data.Beq=[];
   data.nonlcon='';
   data.settings=[0];
   data.options=optimset('fmincon');
   data.options=optimset(data.options,'Display','iter');
   data.options.MaxSQPIter=1000;
   data.partag={[]};
   data.par=[];
   data.numx=0;
   data.numpar=0;
   data.selx=0;
   data.selpar=0;
   data.selopt=2;
   data.optliststring={'DerivativeCheck' 'Diagnostics' 'DiffMaxChange' 'DiffMinChange' ...
         'Display' 'GradConstr' 'GradObj' 'Hessian' 'LargeScale' ...
         'MaxFunEvals' 'MaxIter' 'MaxPCGIter' 'MaxSQPIter' 'PrecondBandWidth' 'TolCon' ...
         'TolFun' 'TolPCG' 'TolX'};
   popuponoff={'popupmenu' {'on' 'off'}}; 
   editposscalar={'edit' {'scalar' 'positive scalar'}};
   editposint={'edit' {'scalar' 'positive integer'}};
   edit0posintinf={'edit' {'scalar' '0 positive integer inf'}};
   data.optlistcells={popuponoff popuponoff editposscalar editposscalar ...
         {'popupmenu' {'off' 'iter' 'final'}} popuponoff popuponoff popuponoff popuponoff ...
         editposint editposint editposint editposint edit0posintinf editposscalar ...
         editposscalar editposscalar editposscalar};      
   data.results.errmsg='';
   data.results.Z=inf;
   data.results.X=[];
   data.results.t=0;
   data.results.c=0;
   data.results.fail=0;
   data.results.msg='BNB GUI 2.0 for BNB 20';
   handles.main=[];
   handles.fun=[];
   handles.set=[];
   handles.err=[];
case('main')
   if ~ih(handles.main)
      handles.main=guimain;
   end;
   if data.numx>0
      onoffx(handles,'on');
      handle=findobj(handles.main,'Tag','xlist');
      set(handle,'String',num2str([1:data.numx]'));
      set(handle,'Value',data.selx);
      updatex(handles,data);
   else onoffx(handles,'off'); end;
   if data.numpar>0
      onoffpar(handles,'on');
      handle=findobj(handles.main,'Tag','parlist');
      set(handle,'String',num2str([1:data.numpar]'));
      set(handle,'Value',data.selpar);
      updatepar(handles,data);
   else onoffpar(handles,'off'); end;
   handle1=findobj(handles.main,'Tag','results');
   handle2=findobj(handles.main,'Tag','resultsslider');
   initwindowslider(handle1,handle2,data.results.msg);
case('save')
   [file,path]=uiputfile('bnb.mat','Select mat-file to save data.');
   if file~=0
      BNBdata=data;
      eval(['save ',fullfile(path,file),' BNBdata;'],'handles.err=uierror(''Data has not been saved.'')');
   end;
case('load')
   if ~exist('file'), file=uigetfile('bnb.mat','Select mat-file to load settings.'); end;
   if file~=0
      check=1;
      eval(['load ',file,' BNBdata;'],'handles.err=uierror(''File not found.''); check=0;');
      if check==1
         if exist('BNBdata') & isstruct(BNBdata) ...
               & isfield(BNBdata,'id') & strcmp(BNBdata.id,'BNBGUI20 BNB20')
            mlock;
            data=BNBdata;
            bnbguicb('main');
            if ih(handles.fun), bnbguicb('function'); end;
            if ih(handles.set), bnbguicb('settings'); end;
         else handles.err=uierror('Data has not been updated.'); end;
      end;
   end;
case('X -> x0')
   if all(size(data.results.X)==size(data.x0)),
      data.x0=data.results.X;
      if data.numx>0, updatex(handles,data); end;
   end;
case('Z X t c fail -> base')
   assignin('base','Z',data.results.Z);
   assignin('base','X',data.results.X);
   assignin('base','t',data.results.t);
   assignin('base','c',data.results.c);
   assignin('base','fail',data.results.fail);
   disp('The variables Z, X, t, c and fail are loaded in the base workspace.');
case('help')
   edit bnbhelp.txt;
case('copyright')
   msg={'E.C. Kuipers' 'e-mail:' 'E.C.Kuipers@cpedu.rug.nl' 'FI-Lab' ...
         'Applied Physics' 'Rijksuniversiteit Groningen'};
   handles.err=uierror(msg);
   handle=findobj(handles.err,'Tag','error BNB GUI');
   set(handle,'Name','copyright BNB GUI');
   handle=findobj(handles.err,'Tag','error');
   set(handle,'String','copyright');
case('resultsslider')
   handle1=findobj(handles.main,'Tag','results');
   handle2=findobj(handles.main,'Tag','resultsslider');
   updatewindowslider(handle1,handle2);
case('xlist')
   data.selx=selectx(handles);
   updatex(handles,data);
case('xtag')
   handle=gcbo;
   [xtag,succes]=callbackmultiedit(handle,{'edit' {'string'}});
   data.xtag{data.selx}=xtag;
case('x0')
   handle=gcbo;
   [x0,succes]=callbackmultiedit(handle,{'edit' {'scalar' ''}});
   if succes, data.x0(data.selx)=x0; else set(gcbo,'String',data.x0(data.selx)); end; 
case('xlb')
   handle=gcbo;
   [xlb,succes]=callbackmultiedit(handle,{'edit' {'scalar' ''}});
   if succes, data.xlb(data.selx)=xlb; else set(gcbo,'String',data.xlb(data.selx)); end;
case('xub')
   handle=gcbo;
   [xub,succes]=callbackmultiedit(handle,{'edit' {'scalar' ''}});
   if succes, data.xub(data.selx)=xub; else set(gcbo,'String',data.xub(data.selx)); end;
case('continuous')
   data.xstatus(data.selx)=0;
   updatex(handles,data);
case('integer')
   data.xstatus(data.selx)=1;
   updatex(handles,data);
case('fixed')
   data.xstatus(data.selx)=2;
   updatex(handles,data);
case('parlist')
   data.selpar=selectpar(handles);
   updatepar(handles,data);
case('partag')
   handle=gcbo;
   [partag,succes]=callbackmultiedit(handle,{'edit' {'string'}});
   data.partag{data.selpar}=partag;
case('par')
   handle=gcbo;
   [par,succes]=callbackmultiedit(handle,{'edit' {'scalar' ''}});
   if succes, data.par(data.selpar)=par; else set(gcbo,'String',data.par(data.selpar)); end;
case('function')
   if ~ih(handles.fun)
      handles.fun=guifun;
   end;
   set(findobj(handles.fun,'Tag','fun'),'String',data.fun(1:min(12,size(data.fun,2))));
   set(findobj(handles.fun,'Tag','nonlcon'),'String',data.nonlcon(1:min(12,size(data.nonlcon,2))));
   set(findobj(handles.fun,'Tag','numx'),'String',num2str(data.numx));
   set(findobj(handles.fun,'Tag','numpar'),'String',num2str(data.numpar));
   updatefunclear(handles,data);
case('settings')
   if ~ih(handles.set)
      handles.set=guiset;
   end;
   set(findobj(handles.set,'Tag','set1'),'Value',data.settings(1));
   set(findobj(handles.set,'Tag','optlist'),'String',data.optliststring);
   set(findobj(handles.set,'Tag','optlist'),'Value',data.selopt);
   updateoptedit(handles,data);
case('optimize')
   par=num2cell(data.par);
   data.settings(2)=handles.main;
   [data.results.errmsg,data.results.Z,data.results.X,...
      data.results.t,data.results.c,data.results.fail]=...
      bnb20(data.fun,data.x0,data.xstatus,data.xlb,data.xub,...
      data.A,data.B,data.Aeq,data.Beq,data.nonlcon,...
      data.settings,data.options,par{:});
   if ~isempty(data.results.X)
      disp('X is:');
      disp(data.results.X);
      data.results.X(find(data.xstatus==1))=round(data.results.X(find(data.xstatus==1)));
   end;
   data.results.msg=updateresults(data);
   handle1=findobj(handles.main,'Tag','results');
   handle2=findobj(handles.main,'Tag','resultsslider');
   initwindowslider(handle1,handle2,data.results.msg);
case('hide main')
   if ih(handles.main), set(handles.main,'Visible','off'); end;
   if ih(handles.fun), set(handles.fun,'Visible','off'); end;
   if ih(handles.set), set(handles.set,'Visible','off'); end;
case('show main')
   if ih(handles.main), set(handles.main,'Visible','on'); end;
   if ih(handles.fun), set(handles.fun,'Visible','on'); end;
   if ih(handles.set), set(handles.set,'Visible','on'); end;
case('quit main')
   if ih(handles.fun), close(handles.fun); end;
   if ih(handles.set), close(handles.set); end;
   munlock;
   handles.main=[];
case('fun')
   file=uigetfile('*.m','Select m-file for fun(x).');
   if file~=0
      if checkextension(file,'.m')
         data.fun=file(1:(size(file,2)-2));
         set(findobj(handles.fun,'Tag','fun'),'String',data.fun(1:min(12,size(data.fun,2))));
         set(findobj(handles.fun,'Tag','clear fun'),'BackgroundColor',[1 0 0]);
      else handles.err=uierror({'No m-file.' 'fun has not been updated.'}); end;
   end; 
case('edit fun')
   if ~isempty(data.fun), eval(['edit ',data.fun]); else edit; end;
case('clear fun')
   data.fun='';
   set(findobj(handles.fun,'Tag','fun'),'String','');
   set(findobj(handles.fun,'Tag','clear fun'),'BackgroundColor',[0.7529 0.7529 0.7529]);
case('A')
   [succes,A]=loadmatrix('A');
   if succes==1
      data.A=A;
      set(findobj(handles.fun,'Tag','clear A'),'BackgroundColor',[1 0 0]);
   end;
case('clear A')
   data.A=[];
   set(findobj(handles.fun,'Tag','clear A'),'BackgroundColor',[0.7529 0.7529 0.7529]);
case('B')
   [succes,B]=loadmatrix('B');
   if succes==1
      data.B=B;
      set(findobj(handles.fun,'Tag','clear B'),'BackgroundColor',[1 0 0]);
   end;
case('clear B')
   data.B=[];
   set(findobj(handles.fun,'Tag','clear B'),'BackgroundColor',[0.7529 0.7529 0.7529]);   
case('Aeq')
   [succes,Aeq]=loadmatrix('Aeq');
   if succes==1
      data.Aeq=Aeq;
      set(findobj(handles.fun,'Tag','clear Aeq'),'BackgroundColor',[1 0 0]);
   end;
case('clear Aeq')
   data.Aeq=[];
   set(findobj(handles.fun,'Tag','clear Aeq'),'BackgroundColor',[0.7529 0.7529 0.7529]);   
case('Beq')
   [succes,Beq]=loadmatrix('Beq');
   if succes==1
      data.Beq=Beq;
      set(findobj(handles.fun,'Tag','clear Beq'),'BackgroundColor',[1 0 0]);
   end;
case('clear Beq')
   data.Beq=[];
   set(findobj(handles.fun,'Tag','clear Beq'),'BackgroundColor',[0.7529 0.7529 0.7529]);   
case('lincon')
   file=uigetfile('*.mat','Select mat-file for matrixes A,B, Aeq and Beq.');
   if file~=0
      if checkextension(file,'.mat')
         foundfile=1;
         eval(['load ',file,' A B Aeq Beq;'],'foundfile=0; handles.err=uierror(''File not found.'');');
         if foundfile==1
            errmsg={};
            if exist('A'), data.A=A; 
            else errmsg{size(errmsg,2)+1}='A has not been updated'; end; 
            if exist('B'), data.B=B;
            else errmsg{size(errmsg,2)+1}='B has not been updated'; end;
            if exist('Aeq'), data.Aeq=Aeq;
            else errmsg{size(errmsg,2)+1}='Aeq has not been updated'; end;
            if exist('Beq'), data.Beq=Beq;
            else errmsg{size(errmsg,2)+1}='Beq has not been updated'; end;
            updatefunclear(handles,data);
            if size(errmsg,2)>0, handles.err=uierror(errmsg); end;
         end;
      else handles.err=uierror({'No mat-file.' 'lincon has not been updated.'}); end;
   end;
case('nonlcon')
   file=uigetfile('*.m','Select m-file for nonlcon(x).');
   if file~=0
      if checkextension(file,'.m')
         data.nonlcon=file(1:(size(file,2)-2));
         set(findobj(handles.fun,'Tag','nonlcon'),'String',data.nonlcon(1:min(12,size(data.nonlcon,2))));
         set(findobj(handles.fun,'Tag','clear nonlcon'),'BackgroundColor',[1 0 0]);
      else handles.err=uierror({'No m-file.' 'nonlincon has not been updated.'}); end;
   end;
case('edit nonlcon')
   if ~isempty(data.nonlcon), eval(['edit ',data.nonlcon]); else edit; end;
case('clear nonlcon')
   data.nonlcon='';
   set(findobj(handles.fun,'Tag','nonlcon'),'String','');
   set(findobj(handles.fun,'Tag','clear nonlcon'),'BackgroundColor',[0.7529 0.7529 0.7529]);   
case('numx')
   handle=gcbo;
   [numx,succes]=callbackmultiedit(handle,{'edit' {'scalar' '0 positive integer'}});
   if succes
      data.numx=numx;
      if numx==0
         data.x0=[];
         data.xstatus=[];
         data.xlb=[];
         data.xub=[];
         data.xtag={[]};
         onoffx(handles,'off');
      else
         lx=size(data.x0,1);
         if numx>lx
            data.x0=[data.x0;zeros(numx-lx,1)];
            data.xstatus=[data.xstatus;zeros(numx-lx,1)];
            data.xlb=[data.xlb;zeros(numx-lx,1)];
            data.xub=[data.xub;ones(numx-lx,1)];
            data.xtag{numx,1}=[]; 
         else
            data.x0=data.x0(1:numx);
            data.xstatus=data.xstatus(1:numx);
            data.xlb=data.xlb(1:numx);
            data.xub=data.xub(1:numx);
            data.xtag={data.xtag{1:numx}}';
         end;
         data.selx=selectx(handles);
         handle=findobj(handles.main,'Tag','xlist');
         if numx<data.selx, set(handle,'Value',numx); data.selx=selectx(handles); end;
         set(handle,'String',num2str([1:numx]'));
         updatex(handles,data);
         onoffx(handles,'on');
      end;
   else
      set(gcbo,'String',data.numx);
   end;
case('numpar')
   handle=gcbo;
   [numpar,succes]=callbackmultiedit(handle,{'edit' {'scalar' '0 positive integer'}});
   if succes
      data.numpar=numpar;
      if numpar==0
         data.par=[];
         data.partag={[]};
         onoffpar(handles,'off');
      else
         lpar=size(data.par,1);
         if numpar>lpar
            data.par=[data.par;zeros(numpar-lpar,1)];
            data.partag{numpar,1}=[];
         else
            data.par=data.par(1:numpar);
            data.partag={data.partag{1:numpar}}';
         end;
         data.selpar=selectpar(handles);
         handle=findobj(handles.main,'Tag','parlist');
         if numpar<data.selpar, set(handle,'Value',numpar); data.selpar=selectpar(handles); end;
         set(handle,'String',num2str([1:numpar]'));
         updatepar(handles,data);
         onoffpar(handles,'on');
      end;
   else
      set(gcbo,'String',data.numpar);
   end;
case('to base')
   assignin('base','fun',data.fun);
   assignin('base','A',data.A);
   assignin('base','B',data.B);
   assignin('base','Aeq',data.Aeq);
   assignin('base','Beq',data.Beq);
   assignin('base','nonlcon',data.nonlcon);
   disp('The variables fun, A, B, Aeq, Beq and nonlcon are loaded in the base workspace.');
case('from base')
   fun=evalin('base','fun','data.fun');
   if ischar(fun), data.fun=fun; end;
   A=evalin('base','A','data.A');
   if isnumeric(A) & isreal(A), data.A=A; end;
   B=evalin('base','B','data.B');
   if isnumeric(B) & isreal(B), data.B=B; end;
   Aeq=evalin('base','Aeq','data.Aeq');
   if isnumeric(Aeq) & isreal(Aeq), data.Aeq=Aeq; end;
   Beq=evalin('base','Beq','data.Beq');
   if isnumeric(Beq) & isreal(Beq), data.Beq=Beq; end;
   nonlcon=evalin('base','nonlcon','data.nonlcon');
   if ischar(nonlcon), data.nonlcon=nonlcon; end;
   disp('The variables fun, A, B, Aeq, Beq and nonlcon are loaded from the base workspace.');   
   set(findobj(handles.fun,'Tag','fun'),'String',data.fun(1:min(12,size(data.fun,2))));
   set(findobj(handles.fun,'Tag','nonlcon'),'String',data.nonlcon(1:min(12,size(data.nonlcon,2))));
   updatefunclear(handles,data);
case('quit fun')
   handles.fun=[];
case('set1')
   data.settings(1)=get(gcbo,'Value');
case('optlist')
   data.selopt=selectopt(handles);
   updateoptedit(handles,data);
case('optedit')
   data=callbackoptedit(handles,data);
case('quit set')
   handles.set=[];
case('errorslider')
   handle1=findobj(handles.err,'Tag','errormessage');
   handle2=findobj(handles.err,'Tag','errorslider');
   updatewindowslider(handle1,handle2);
case('quit err')
   handles.err=[];
otherwise
   help bnbguicb
   disp('  bnbguicb could not handle your request (action).');
end;

function selx=selectx(handles);
handle=findobj(handles.main,'Tag','xlist');
selx=get(handle,'Value');

function updatex(handles,data);
handle=findobj(handles.main,'Tag','xtag');
set(handle,'String',data.xtag{data.selx});
handle=findobj(handles.main,'Tag','xub');
set(handle,'String',num2str(data.xub(data.selx)));
handle=findobj(handles.main,'Tag','x0');
set(handle,'String',num2str(data.x0(data.selx)));
handle=findobj(handles.main,'Tag','xlb');
set(handle,'String',num2str(data.xlb(data.selx)));
handle=findobj(handles.main,'Tag','continuous');
set(handle,'Value',data.xstatus(data.selx)==0);
handle=findobj(handles.main,'Tag','integer');
set(handle,'Value',data.xstatus(data.selx)==1);
handle=findobj(handles.main,'Tag','fixed');
set(handle,'Value',data.xstatus(data.selx)==2);

function onoffx(handles,onoff);
handle=findobj(handles.main,'Tag','xlist');
set(handle,'Enable',onoff);
handle=findobj(handles.main,'Tag','xtag');
set(handle,'Enable',onoff);
handle=findobj(handles.main,'Tag','xub');
set(handle,'Enable',onoff);
handle=findobj(handles.main,'Tag','x0');
set(handle,'Enable',onoff);
handle=findobj(handles.main,'Tag','xlb');
set(handle,'Enable',onoff);
handle=findobj(handles.main,'Tag','continuous');
set(handle,'Enable',onoff);
handle=findobj(handles.main,'Tag','integer');
set(handle,'Enable',onoff);
handle=findobj(handles.main,'Tag','fixed');
set(handle,'Enable',onoff);

function selpar=selectpar(handles);
handle=findobj(handles.main,'Tag','parlist');
selpar=get(handle,'Value');

function updatepar(handles,data);
handle=findobj(handles.main,'Tag','partag');
set(handle,'String',data.partag{data.selpar});
handle=findobj(handles.main,'Tag','par');
set(handle,'String',num2str(data.par(data.selpar)));

function onoffpar(handles,onoff);
handle=findobj(handles.main,'Tag','parlist');
set(handle,'Enable',onoff);
handle=findobj(handles.main,'Tag','partag');
set(handle,'Enable',onoff);
handle=findobj(handles.main,'Tag','par');
set(handle,'Enable',onoff);

function selopt=selectopt(handles);
handle=findobj(handles.set,'Tag','optlist');
selopt=get(handle,'Value');

function updatefunclear(handles,data);
if isempty(data.fun), color=[0.7529 0.7529 0.7529];
else color=[1 0 0]; end;
handle=findobj(handles.fun,'Tag','clear fun');
set(handle,'BackgroundColor',color);
if isempty(data.A), color=[0.7529 0.7529 0.7529];
else color=[1 0 0]; end;
handle=findobj(handles.fun,'Tag','clear A');
set(handle,'BackgroundColor',color);
if isempty(data.B), color=[0.7529 0.7529 0.7529];
else color=[1 0 0]; end;
handle=findobj(handles.fun,'Tag','clear B');
set(handle,'BackgroundColor',color);
if isempty(data.Aeq), color=[0.7529 0.7529 0.7529];
else color=[1 0 0]; end;
handle=findobj(handles.fun,'Tag','clear Aeq');
set(handle,'BackgroundColor',color);
if isempty(data.Beq), color=[0.7529 0.7529 0.7529];
else color=[1 0 0]; end;
handle=findobj(handles.fun,'Tag','clear Beq');
set(handle,'BackgroundColor',color);
if isempty(data.nonlcon), color=[0.7529 0.7529 0.7529];
else color=[1 0 0]; end;
handle=findobj(handles.fun,'Tag','clear nonlcon');
set(handle,'BackgroundColor',color);

function handle=uierror(errmsg)
handle=guierr;
handle1=findobj(handle,'Tag','errormessage');
handle2=findobj(handle,'Tag','errorslider');
initwindowslider(handle1,handle2,errmsg);

function resultsmsg=updateresults(data)
if isempty(data.results.errmsg)
   line1='Results BNB20:';
   line2=sprintf('Z            : %12.4e',data.results.Z);
   line3=sprintf('t            : %12.1f seconds',data.results.t);
   line4=sprintf('c            : %12d cycles',data.results.c);
   line5=sprintf('fail         : %12d cycles',data.results.fail);
   resultsmsg={line1;line2;line3;line4;line5};
   for i=1:size(data.results.X,1)
      newline=sprintf('             : %12.4g',data.results.X(i));
      if isempty(data.xtag{i}), tag=['X(',num2str(i),')'];
      else tag=data.xtag{i}; end;
      j=min(12,size(tag,2));
      newline(1:j)=tag(1:j);
      resultsmsg=[resultsmsg;{newline}];   
   end;
else
   line1='Results BNB20:';
   line2='Error.';
   line3=data.results.errmsg;
   resultsmsg={line1 line2 line3};
end;

function [succes,matrix]=loadmatrix(matrixname);
succes=0; matrix=[];
file=uigetfile('*.mat',['Select mat-file for matrix ',matrixname,'.']);
if file~=0 
   if checkextension(file,'.mat')
      foundfile=1;
      eval(['load ',file,' ',matrixname,';'],'foundfile=0; uierror(''File not found.'');');
      if foundfile==1
         if exist(matrixname), matrix=eval(matrixname); succes=1;
         else uierror([matrixname,' has not been updated']); end;
      end;
   else uierror({'No mat-file.' [matrixname,' has not been updated.']}); end;
end;

function extflag=checkextension(file,extension)
[path,name,ext,ver] = fileparts(file);
if strcmpi(ext,extension)==1, extflag=1;
else extflag=0; end;

function initwindowslider(windowhandle,sliderhandle,text);
if ischar(text), text=cellstr(text); end;
windowdata.text=textwrap(windowhandle,text);
windowdata.textlines=size(windowdata.text,1);
fontunits=get(windowhandle,'FontUnits');
if ~strcmp(fontunits,'points'), error; end;
fontname=get(windowhandle,'FontName');
if ~strcmp(fontname,'Courier-LD'), error; end;
fontsize=get(windowhandle,'FontSize');
position=get(windowhandle,'Position');
windowheight=position(4);
windowdata.visiblelines=floor((windowheight-1)/fontsize);
windowdata.usedlines=min(windowdata.textlines,windowdata.visiblelines);
set(windowhandle,'UserData',windowdata);
set(windowhandle,'String',windowdata.text(1:windowdata.usedlines));
set(sliderhandle,'Value',1);
if windowdata.textlines<=windowdata.visiblelines
   set(sliderhandle,'Enable','off');
else
   sliderstep=[1/(windowdata.textlines-windowdata.visiblelines) ...
         windowdata.visiblelines/(windowdata.textlines-windowdata.visiblelines)];
   set(sliderhandle,'SliderStep',sliderstep);
   set(sliderhandle,'Enable','on');
end;

function updatewindowslider(windowhandle,sliderhandle)
slidervalue=get(sliderhandle,'Value');
sliderstep=get(sliderhandle,'SliderStep');
hiddenlinesbefore=round((1-slidervalue)/sliderstep(1));
windowdata=get(windowhandle,'UserData');
text=windowdata.text(hiddenlinesbefore+1:hiddenlinesbefore+windowdata.usedlines);
set(windowhandle,'String',text);

function updatemultiedit(handle,mecell,currentvalue)
set(handle,'Style',mecell{1});
if strcmp(mecell{1},'popupmenu')
   set(handle,'String',mecell{2});
   maxsel=length(mecell{2});
   currsel=1;
   while ~strcmp(currentvalue,mecell{2}{currsel})
      currsel=currsel+1;
      if currsel>maxsel, currsel=1; break; end;
   end;
   set(handle,'Value',currsel);
elseif strcmp(mecell{1},'edit')
   set(handle,'String',currentvalue);
else error; end;   

function [val,succes]=callbackmultiedit(handle,mecell);
succes=1;
val=[];
if strcmp(mecell{1},'popupmenu')
   currsel=get(handle,'Value');
   string=get(handle,'String');
   val=string{currsel};
elseif strcmp(mecell{1},'edit')
   if strcmp(mecell{2}{1},'string')
      val=get(handle,'String');
   elseif strcmp(mecell{2}{1},'scalar')
      val=str2num(get(handle,'String'));
      if any(size(val)~=1), succes=0; return; end;
      if ~isnumeric(val) | ~isreal(val), succes=0; return; end;
      if strcmp(mecell{2}{2},'positive scalar')
         if val<=0, succes=0; return; 
         elseif ~isfinite(val), succes=0; return; end;
      elseif strcmp(mecell{2}{2},'positive integer')
         if val<=0, succes=0; return;
         elseif ~isfinite(val), succes=0; return;
         elseif round(val)~=val, succes=0; return; end;
      elseif strcmp(mecell{2}{2},'0 positive integer inf')
         if val<0, succes=0; return;
         elseif round(val)~=val, succes=0; return; end;
      elseif strcmp(mecell{2}{2},'0 positive integer')
         if val<0, succes=0; return;
         elseif ~isfinite(val), succes=0; return; 
         elseif round(val)~=val, succes=0; return; end;
      elseif strcmp(mecell{2}{2},'')
      else error; end;
   else error; end;
else error; end;      

function updateoptedit(handles,data)
handle=findobj(handles.set,'Tag','optedit');
mecell=data.optlistcells{data.selopt};
currentvalue=getfield(data.options,data.optliststring{data.selopt});
if isnumeric(currentvalue), currentvalue=num2str(currentvalue); end;
updatemultiedit(handle,mecell,currentvalue);

function data=callbackoptedit(handles,data);
handle=gcbo;
mecell=data.optlistcells{data.selopt};
[val succes]=callbackmultiedit(handle,mecell);
if succes
   data.options=setfield(data.options,data.optliststring{data.selopt},val);
else
   updateoptedit(handles,data)
end;

function result=ih(handle)
if isempty(handle), result=0; return; end;
   result=ishandle(handle);
   