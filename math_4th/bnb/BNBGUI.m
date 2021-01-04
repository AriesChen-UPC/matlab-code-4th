function BNBGUI(file)
% BNGUI Runs a GUI for BNB20. Version 2.0.
% Usage: BNBGUI
% or     BNBGUI(file)
%
% file is a MAT-file saved by BNBGUI. 
%
% The GUI has (some) online help.
%
% E.C. Kuipers
% e-mail E.C.Kuipers@cpedu.rug.nl 
% FI-Lab
% Applied Physics
% Rijksuniversiteit Groningen
%
% BNBGUI uses:
% bnbgui.m bnbguicb.m guierr.m guierr.mat guifun.m guifun.mat
% guimain.m guimain.mat guiset.m guiset.mat bnb20.m
% 
% BNB20 uses:
% Optimization Toolbox Version 2.0 (R11) 09-Oct-1998
% From this toolbox fmincon.m is called.
%
if nargin==0
   handle=findobj('Tag','main BNB GUI');
   if ishandle(handle)
      bnbguicb('show main');
   else
      bnbguicb('init');
      bnbguicb('main');
   end;
elseif nargin==1
   bnbguicb('load',file);
else
   help bnbgui;
end;

