	function [x,FVAL,lambda_out,EXITFLAG,OUTPUT,GRADIENT,HESS]= ...
   nlconst(funfcn,x,lb,ub,Ain,Bin,Aeq,Beq,confcn,OPTIONS,...
   verbosity,gradflag,gradconstflag,hessflag,meritFunctionType,...
   CHG,fval,gval,Hval,ncineqval,nceqval,gncval,gnceqval,varargin);
%NLCONST Helper function to find the constrained minimum of a function 
%   of several variables. Called by CONSTR, ATTGOAL. SEMINF and MINIMAX.
%
%   [X,OPTIONS,LAMBDA,HESS]=NLCONST('FUN',X0,OPTIONS,lb,ub,'GRADFUN',...
%   varargin{:}) starts at X0 and finds a constrained minimum to 
%   the function which is described in FUN. FUN is a four element cell array
%   set up by PREFCNCHK.  It contains the call to the objective/constraint
%   function, the gradients of the objective/constraint functions, the
%   calling type (used by OPTEVAL), and the calling function name. 
%
%   Copyright (c) 1990-98 by The MathWorks, Inc.
%   $Revision: 1.20 $  $Date: 1998/08/24 13:46:15 $
%   Andy Grace 7-9-90, Mary Ann Branch 9-30-96.

%   Called by CONSTR, SEMINF, ATTGOAL, MINIMAX.
%   Calls OPTEVAL.
%
%   meritFunctionType==5 for fseminf
%                    ==1 for fminimax & fgoalattain (can use 0, but 1 is default)
%                    ==0 for fmincon

FVAL=[];lambda=[];EXITFLAG =1; OUTPUT=[]; HESS=[];
% Expectations: GRADfcn must be [] if it does not exist.
global OPT_STOP OPT_STEP;
OPT_STEP = 1; 
OPT_STOP = 0; 
% Initialize so if OPT_STOP these have values
lambda = []; HESS = [];
iter = 0;
% Set up parameters.
XOUT=x(:);
% numberOfVariables must be the name of this variable
numberOfVariables = length(XOUT);

Nlconst = 'nlconst';
tolX = optimget(OPTIONS,'TolX');
tolFun = optimget(OPTIONS,'tolfun');
tolCon = optimget(OPTIONS,'tolcon');
DiffMinChange = optimget(OPTIONS,'diffminchange');
DiffMaxChange = optimget(OPTIONS,'diffmaxchange');
DerivativeCheck = strcmp(optimget(OPTIONS,'DerivativeCheck'),'on');
maxFunEvals = optimget(OPTIONS,'maxfunevals');
maxIter = optimget(OPTIONS,'maxIter');
% In case the defaults were gathered from calling: optimset('fminsearch'):
if ischar(maxFunEvals)
   maxFunEvals = eval(maxFunEvals);
end


% Handle bounds as linear constraints
arglb = ~isinf(lb);
lenlb=length(lb); % maybe less than numberOfVariables due to old code
argub = ~isinf(ub);
lenub=length(ub);
boundmatrix = eye(max(lenub,lenlb),numberOfVariables);

if nnz(arglb) > 0     
   lbmatrix = -boundmatrix(arglb,1:numberOfVariables);% select non-Inf bounds 
   lbrhs = -lb(arglb);
else
   lbmatrix = []; lbrhs = [];
end

if nnz(argub) > 0
   ubmatrix = boundmatrix(argub,1:numberOfVariables);
   ubrhs=ub(argub);
else
   ubmatrix = []; ubrhs=[];
end 

bestf = Inf; 
if isempty(confcn{1})
   constflag = 0;
else
   constflag = 1;
end

A = [lbmatrix;ubmatrix;Ain];
B = [lbrhs;ubrhs;Bin];

if isempty(A)
   A = zeros(0,numberOfVariables); B=zeros(0,1);
end
if isempty(Aeq)
   Aeq = zeros(0,numberOfVariables); Beq=zeros(0,1);
end


% Used for semi-infinite optimization:
s = nan; POINT =[]; NEWLAMBDA =[]; LAMBDA = []; NPOINT =[]; FLAG = 2;
OLDLAMBDA = [];

x(:) = XOUT;  % Set x to have user expected size
% Compute the objective function and constraints
if strcmp(funfcn{2},'fseminf')
   f = fval;
   [ncineq,nceq,NPOINT,NEWLAMBDA,OLDLAMBDA,LOLD,s] = ...
      semicon(x,LAMBDA,NEWLAMBDA,OLDLAMBDA,POINT,FLAG,s,varargin{:});
else
   f = fval;
   nceq = nceqval; ncineq = ncineqval;  % nonlinear constraints only
   %c = [Aeq*XOUT-Beq; ceq; A*XOUT-B; c];
end

non_eq = length(nceq);
non_ineq = length(ncineq);
[lin_eq,Aeqcol] = size(Aeq);
[lin_ineq,Acol] = size(A);  % includes upper and lower
eq = non_eq + lin_eq;
ineq = non_ineq + lin_ineq;
nc = [nceq; ncineq];

ncstr = ineq + eq;

if isempty(f)
   error('FUN must return a non-empty objective function.')
end

% Evaluate gradients and check size
if gradflag | gradconstflag %evaluate analytic gradient
   if gradflag
      gf_user = gval;
   end
   
   if gradconstflag
      gnc_user = [  gnceqval, gncval];   % Don't include A and Aeq yet
   else
      gnc_user = [];
   end
   if isempty(gnc_user) & isempty(nc)
      % Make gc compatible
      gnc = nc'; gnc_user = nc';
   end % isempty(gnc_user) & isempty(nc)
end
c = [ Aeq*XOUT-Beq; nceq; A*XOUT-B; ncineq];

OLDX=XOUT;
OLDC=c; OLDNC=nc;
OLDgf=zeros(numberOfVariables,1);
gf=zeros(numberOfVariables,1);
OLDAN=zeros(ncstr,numberOfVariables);
LAMBDA=zeros(ncstr,1);

stepsize=1;

if meritFunctionType==1
   if isequal(funfcn{2},'fgoalattain')
      header = sprintf(['\n                    Attainment                 Directional \n',...
                          ' Iter   F-count       factor      Step-size     derivative    Procedure ']);

   else
   header = sprintf(['\n                       Max                     Directional \n',...
                       ' Iter   F-count  {F,constraints}  Step-size     derivative    Procedure ']);
   end
   formatstr = '%5.0f  %5.0f   %12.4g %12.3g    %12.3g   %s  %s';
else % fmincon is caller
   header = sprintf(['\n                                     max                      Directional \n',...
                       ' Iter   F-count      f(x)         constraint    Step-size      derivative   Procedure ']);
   formatstr = '%5.0f  %5.0f   %12.6g %12.4g %12.3g    %12.3g   %s  %s';
end
if verbosity > 1
   disp(header)
end

HESS=eye(numberOfVariables,numberOfVariables);

numFunEvals=1;
numGradEvals=1;
GNEW=1e8*CHG;
%---------------------------------Main Loop-----------------------------
status = 0; EXITFLAG = 1;
while status ~= 1
   iter = iter + 1;
   
   %----------------GRADIENTS----------------
   
   if ~gradconstflag | ~gradflag | DerivativeCheck
      % Finite Difference gradients (even if just checking analytical)
      POINT = NPOINT; 
      oldf = f;
      oldnc = nc;
      len_nc = length(nc);
      ncstr =  lin_eq + lin_ineq + len_nc;     
      FLAG = 0; % For semi-infinite
      gnc = zeros(numberOfVariables, len_nc);  % For semi-infinite
      % Try to make the finite differences equal to 1e-8.
      CHG = -1e-8./(GNEW+eps);
      CHG = sign(CHG+eps).*min(max(abs(CHG),DiffMinChange),DiffMaxChange);
      OPT_STEP = 1;
      for gcnt=1:numberOfVariables
         if gcnt == numberOfVariables, 
            FLAG = -1; 
         end
         temp = XOUT(gcnt);
         XOUT(gcnt)= temp + CHG(gcnt);
         x(:) =XOUT; 
         if ~gradflag | DerivativeCheck
            if strcmp(funfcn{2},'fseminf')
               f= feval(funfcn{3},x,varargin{3:end});
            else
               
               f = feval(funfcn{3},x,varargin{:});
            end
            
            gf(gcnt,1) = (f-oldf)/CHG(gcnt);
         end
         if ~gradconstflag | DerivativeCheck
            if constflag
               if strcmp(confcn{2},'fseminf')
                  [nctmp,nceqtmp,NPOINT,NEWLAMBDA,OLDLAMBDA,LOLD,s] = ...
                     semicon(x,LAMBDA,NEWLAMBDA,OLDLAMBDA,POINT,FLAG,s,varargin{:});
               else
                  [nctmp,nceqtmp] = feval(confcn{3},x,varargin{:});
               end
               nc = [nceqtmp(:); nctmp(:)];
            end
            % Next line used for problems with varying number of constraints
            if len_nc~=length(nc) & isequal(funfcn{2},'fseminf')
               diff=length(nc); 
               nc=v2sort(oldnc,nc); 
               
            end
            
            if ~isempty(nc)
               gnc(gcnt,:) = (nc - oldnc)'/CHG(gcnt); 
            end
           
         end
         
         OPT_STEP = 0;
         if OPT_STOP
            break;
         end
         XOUT(gcnt) = temp;
         
         if OPT_STOP
            break;
         end
      end % for 
      
      % Gradient check
      if DerivativeCheck == 1 & (gradflag | gradconstflag) % analytic exists
                           
         disp('Function derivative')
         if gradflag
            gfFD = gf;
            gf = gf_user;
            
            if isa(funfcn{4},'inline')
               graderr(gfFD, gf, formula(funfcn{4}));
            else
               graderr(gfFD, gf, funfcn{4});
            end
         end
         
         if gradconstflag
            gncFD = gnc; 
            gnc = gnc_user;
            
            disp('Constraint derivative')
            if isa(confcn{4},'inline')
               graderr(gncFD, gnc, formula(confcn{4}));
            else
               graderr(gncFD, gnc, confcn{4});
            end
         end         
         DerivativeCheck = 0;
      elseif gradflag | gradconstflag
         if gradflag
            gf = gf_user;
         end
         if gradconstflag
            gnc = gnc_user;
         end
      end % DerivativeCheck == 1 &  (gradflag | gradconstflag)
      
      FLAG = 1; % For semi-infinite
      numFunEvals = numFunEvals + numberOfVariables;
      f=oldf;
      nc=oldnc;
   else% gradflag & gradconstflag & no DerivativeCheck 
      gnc = gnc_user;
      gf = gf_user;
   end  
   
   % Now add in Aeq, and A
   if ~isempty(gnc)
      gc = [Aeq', gnc(:,1:non_eq), A', gnc(:,non_eq+1:non_ineq+non_eq)];
   elseif ~isempty(Aeq) | ~isempty(A)
      gc = [Aeq',A'];
   else
      gc = zeros(numberOfVariables,0);
   end
   AN=gc';
   how='';
   OPT_STEP = 2;
   
   %-------------SEARCH DIRECTION---------------
   % For equality constraints make gradient face in 
   % opposite direction to function gradient.
   for i=1:eq 
      schg=AN(i,:)*gf;
      if schg>0
         AN(i,:)=-AN(i,:);
         c(i)=-c(i);
      end
   end
   
   if numGradEvals>1  % Check for first call    
      if meritFunctionType~=5,   
         NEWLAMBDA=LAMBDA; 
      end
      [ma,na] = size(AN);
      GNEW=gf+AN'*NEWLAMBDA;
      GOLD=OLDgf+OLDAN'*LAMBDA;
      YL=GNEW-GOLD;
      sdiff=XOUT-OLDX;
      % Make sure Hessian is positive definite in update.
      if YL'*sdiff<stepsize^2*1e-3
         while YL'*sdiff<-1e-5
            [YMAX,YIND]=min(YL.*sdiff);
            YL(YIND)=YL(YIND)/2;
         end
         if YL'*sdiff < (eps*norm(HESS,'fro'));
            how=' Hessian modified twice';
            FACTOR=AN'*c - OLDAN'*OLDC;
            FACTOR=FACTOR.*(sdiff.*FACTOR>0).*(YL.*sdiff<=eps);
            WT=1e-2;
            if max(abs(FACTOR))==0; FACTOR=1e-5*sign(sdiff); end
            while YL'*sdiff < (eps*norm(HESS,'fro')) & WT < 1/eps
               YL=YL+WT*FACTOR;
               WT=WT*2;
            end
         else
            how=' Hessian modified';
         end
      end
      
      %----------Perform BFGS Update If YL'S Is Positive---------
      if YL'*sdiff>eps
         HESS=HESS ...
            +(YL*YL')/(YL'*sdiff)-((HESS*sdiff)*(sdiff'*HESS'))/(sdiff'*HESS*sdiff);
         % BFGS Update using Cholesky factorization  of Gill, Murray and Wright.
         % In practice this was less robust than above method and slower. 
         %   R=chol(HESS); 
         %   s2=R*S; y=R'\YL; 
         %   W=eye(numberOfVariables,numberOfVariables)-(s2'*s2)\(s2*s2') + (y'*s2)\(y*y');
         %   HESS=R'*W*R;
      else
         how=' Hessian not updated';
      end
      
   else % First call
      OLDLAMBDA=(eps+gf'*gf)*ones(ncstr,1)./(sum(AN'.*AN')'+eps) ;
   end % if numGradEvals>1
   numGradEvals=numGradEvals+1;
   
   LOLD=LAMBDA;
   OLDAN=AN;
   OLDgf=gf;
   OLDC=c;
   OLDF=f;
   OLDX=XOUT;
   XN=zeros(numberOfVariables,1);
   if (meritFunctionType>0 & meritFunctionType<5)
      % Minimax and attgoal problems have special Hessian:
      HESS(numberOfVariables,1:numberOfVariables)=zeros(1,numberOfVariables);
      HESS(1:numberOfVariables,numberOfVariables)=zeros(numberOfVariables,1);
      HESS(numberOfVariables,numberOfVariables)=1e-8*norm(HESS,'inf');
      XN(numberOfVariables)=max(c); % Make a feasible solution for qp
   end
   
   GT =c;
   
   HESS = (HESS + HESS')*0.5;
   [SD,lambda,exitflagqp,outputqp,howqp] ...
      = qpsub(HESS,gf,AN,-GT,[],[],XN,eq,-1, ...
      Nlconst,size(AN,1),numberOfVariables); 
   
   lambda((1:eq)') = abs(lambda( (1:eq)' ));
   ga=[abs(c( (1:eq)' )) ; c( (eq+1:ncstr)' ) ];
   if ~isempty(c)
      mg=max(ga);
   else
      mg = 0;
   end
   
   if verbosity>1
      if strncmp(howqp,'ok',2); 
         howqp =''; 
      end
      if ~isempty(how) & ~isempty(howqp) 
         how = [how,'; '];
      end
      if meritFunctionType==1,
         gamma = mg+f;
         CurrOutput = sprintf(formatstr,iter,numFunEvals,gamma,stepsize,gf'*SD,how,howqp); 
         disp(CurrOutput)

      else
         CurrOutput = sprintf(formatstr,iter,numFunEvals,f,mg,stepsize,gf'*SD,how,howqp); 
         disp(CurrOutput)
        % disp([sprintf('%5.0f %12.6g %12.6g ',numFunEvals,f,mg), ...
        %       sprintf('%12.3g  ',stepsize),how, ' ',howqp]);
      end
   end
   LAMBDA=lambda((1:ncstr)');
   OLDLAMBDA=max([LAMBDA';0.5*(LAMBDA+OLDLAMBDA)'])' ;
   
   %---------------LINESEARCH--------------------
   MATX=XOUT;
   MATL = f+sum(OLDLAMBDA.*(ga>0).*ga) + 1e-30;
   infeas = strncmp(howqp,'i',1);
   if meritFunctionType==0 | meritFunctionType == 5
      % This merit function looks for improvement in either the constraint
      % or the objective function unless the sub-problem is infeasible in which
      % case only a reduction in the maximum constraint is tolerated.
      % This less "stringent" merit function has produced faster convergence in
      % a large number of problems.
      if mg > 0
         MATL2 = mg;
      elseif f >=0 
         MATL2 = -1/(f+1);
      else 
         MATL2 = 0;
      end
      if ~infeas & f < 0
         MATL2 = MATL2 + f - 1;
      end
   else
      % Merit function used for MINIMAX or ATTGOAL problems.
      MATL2=mg+f;
   end
   if mg < eps & f < bestf
      bestf = f;
      bestx = XOUT;
      bestHess = HESS;
      bestgrad = gf;
      bestlambda = lambda;
   end
   MERIT = MATL + 1;
   MERIT2 = MATL2 + 1; 
   stepsize=2;
   while  (MERIT2 > MATL2) & (MERIT > MATL) ...
         & numFunEvals < maxFunEvals & ~OPT_STOP
      stepsize=stepsize/2;
      if stepsize < 1e-4,  
         stepsize = -stepsize; 
         
         % Semi-infinite may have changing sampling interval
         % so avoid too stringent check for improvement
         if meritFunctionType == 5, 
            stepsize = -stepsize; 
            MATL2 = MATL2 + 10; 
         end
      end
      XOUT = MATX + stepsize*SD;
      x(:)=XOUT; 
      
      if strcmp(funfcn{2},'fseminf')
         f= feval(funfcn{3},x,varargin{3:end});
         
         [nctmp,nceqtmp,NPOINT,NEWLAMBDA,OLDLAMBDA,LOLD,s] = ...
            semicon(x,LAMBDA,NEWLAMBDA,OLDLAMBDA,POINT,FLAG,s,varargin{:});
         nctmp = nctmp(:); nceqtmp = nceqtmp(:);
         non_ineq = length(nctmp);  % the length of nctmp can change
         ineq = non_ineq + lin_ineq;
         ncstr = ineq + eq;
         
      else
         f = feval(funfcn{3},x,varargin{:});
         if constflag
            [nctmp,nceqtmp] = feval(confcn{3},x,varargin{:});
            nctmp = nctmp(:); nceqtmp = nceqtmp(:);
         else
            nctmp = []; nceqtmp=[];
         end
      end
            
      nc = [nceqtmp(:); nctmp(:)];
      c = [Aeq*XOUT-Beq; nceqtmp(:); A*XOUT-B; nctmp(:)];  
      
      if OPT_STOP
         break;
      end
      
      numFunEvals = numFunEvals + 1;
      ga=[abs(c( (1:eq)' )) ; c( (eq+1:length(c))' )];
      if ~isempty(c)
         mg=max(ga);
      else
         mg = 0;
      end
      
      MERIT = f+sum(OLDLAMBDA.*(ga>0).*ga);
      if meritFunctionType==0 | meritFunctionType == 5
         if mg > 0
            MERIT2 = mg;
         elseif f >=0 
            MERIT2 = -1/(f+1);
         else 
            MERIT2 = 0;
         end
         if ~infeas & f < 0
            MERIT2 = MERIT2 + f - 1;
         end
      else
         MERIT2=mg+f;
      end
   end  % line search loop
   %------------Finished Line Search-------------
   
   if meritFunctionType~=5
      mf=abs(stepsize);
      LAMBDA=mf*LAMBDA+(1-mf)*LOLD;
   end
   % Test stopping conditions (convergence)
   if (max(abs(SD)) < 2*tolX | abs(gf'*SD) < 2*tolFun ) & ...
         (mg < tolCon | (strncmp(howqp,'i',1) & mg > 0 ) )
      if verbosity>0
         if ~strncmp(howqp, 'i', 1) 
            disp('Optimization terminated successfully:')
            if max(abs(SD)) < 2*tolX 
               disp(' Search direction less than 2*options.TolX and')
               disp('  maximum constraint violation is less than options.TolCon')
            else
               disp(' Magnitude of directional derivative in search direction ')
               disp('  less than 2*options.TolFun and maximum constraint violation ')
               disp('  is less than options.TolCon')     
            end
            
            active_const = find(LAMBDA>0);
            if active_const 
               disp('Active Constraints:'), 
               disp(active_const) 
            else % active_const == 0
               disp(' No Active Constraints');
            end 
         end
         
         if (strncmp(howqp, 'i',1) & mg > 0)
            disp('Optimization terminated: No feasible solution found.')
            if max(abs(SD)) < 2*tolX 
               disp(' Search direction less than 2*options.TolX but constraints are not satisfied.')
            else
               disp(' Magnitude of directional derivative in search direction ')
               disp('  less than 2*options.TolFun but constraints are not satisfied.')    
            end
            EXITFLAG = -1;   
         end
      end
      status=1;
      if (strncmp(howqp, 'i',1) & mg > 0), EXITFLAG = -1; end;
   else % continue
      % NEED=[LAMBDA>0] | G>0
      if numFunEvals > maxFunEvals  | OPT_STOP
         XOUT = MATX;
         f = OLDF;
         if ~OPT_STOP
            if verbosity > 0
               disp('Maximum number of function evaluations exceeded;')
               disp('increase OPTIONS.MaxFunEvals')
            end
         end
         EXITFLAG = 0;
         status=1;
      end
      if iter > maxIter
         XOUT = MATX;
         f = OLDF;
         if verbosity > 0
            disp('Maximum number of function evaluations exceeded;')
            disp('increase OPTIONS.MaxIter')
         end
         EXITFLAG = 0;
         status=1;
      end
   end 
   
   x(:) = XOUT;
   switch funfcn{1} % evaluate function gradients
   case 'fun'
      ;  % do nothing...will use finite difference.
   case 'fungrad'
      [f,gf_user] = feval(funfcn{3},x,varargin{:});
      gf_user = gf_user(:);
      numGradEvals=numGradEvals+1;
   case 'fun_then_grad'
      gf_user = feval(funfcn{4},x,varargin{:});
      gf_user = gf_user(:);
      numGradEvals=numGradEvals+1;
   otherwise
      error('Undefined calltype in FMINCON');
   end
   numFunEvals=numFunEvals+1;
   
   
   % Evaluate constraint gradients
   switch confcn{1}
   case 'fun'
      gnceq=[]; gncineq=[];
   case 'fungrad'
      [nctmp,nceqtmp,gncineq,gnceq] = feval(confcn{3},x,varargin{:});
      nctmp = nctmp(:); nceqtmp = nceqtmp(:);
      numGradEvals=numGradEvals+1;
   case 'fun_then_grad'
      [gncineq,gnceq] = feval(confcn{4},x,varargin{:});
      numGradEvals=numGradEvals+1;
   case ''
      nctmp=[]; nceqtmp =[];
      gncineq = zeros(numberOfVariables,length(nctmp));
      gnceq = zeros(numberOfVariables,length(nceqtmp));
      
   otherwise
      error('Undefined calltype in FMINCON');
   end
   gnc_user = [gnceq, gncineq];
   gc = [Aeq', gnceq, A', gncineq];
   
   
end % while status ~= 1

% Update 
numConstrEvals = numGradEvals;

% Gradient is in the variable gf
GRADIENT = gf;

% If a better unconstrained solution was found earlier, use it:
if f > bestf 
   XOUT = bestx;
   f = bestf;
   HESS = bestHess;
   GRADIENT = bestgrad;
   lambda = bestlambda;
end

FVAL = f;
x(:) = XOUT;
if (OPT_STOP)
   if verbosity > 0
      disp('Optimization terminated prematurely by user')
   end
end


OUTPUT.iterations = iter;
OUTPUT.funcCount = numFunEvals;
OUTPUT.stepsize = stepsize;
OUTPUT.algorithm = 'medium-scale: SQP, Quasi-Newton, line-search';
OUTPUT.firstorderopt = [];
OUTPUT.cgiterations = [];

[lin_ineq,Acol] = size(Ain);  % excludes upper and lower

lambda_out.lower=zeros(lenlb,1);
lambda_out.upper=zeros(lenub,1);

lambda_out.eqlin = lambda(1:lin_eq);
ii = lin_eq ;
lambda_out.eqnonlin = lambda(ii+1: ii+ non_eq);
ii = ii+non_eq;
lambda_out.lower(arglb) = lambda(ii+1 :ii+nnz(arglb));
ii = ii + nnz(arglb) ;
lambda_out.upper(argub) = lambda(ii+1 :ii+nnz(argub));
ii = ii + nnz(argub);
lambda_out.ineqlin = lambda(ii+1: ii + lin_ineq);
ii = ii + lin_ineq ;
lambda_out.ineqnonlin = lambda(ii+1 : end);
