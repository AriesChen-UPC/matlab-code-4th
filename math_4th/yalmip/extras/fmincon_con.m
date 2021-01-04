function [g,geq,dg,dgeq] = fmincon_con(x,model)

% Early bail for linear problems
g = [];
geq = [];
dg = [];
dgeq = [];
if model.linearconstraints
    return
end

xevaled = zeros(1,length(model.c));
xevaled(model.linearindicies) = x;
xevaled = apply_recursive_evaluation(model,xevaled);

if model.nonlinearinequalities
    g = model.Anonlinineq*xevaled(:)-model.bnonlinineq;
else
    g = [];
end

if model.nonlinearequalities
    geq = model.Anonlineq*xevaled(:)-model.bnonlineq;
else
    geq = [];
end

if isempty(model.evalMap) & (model.nonlinearinequalities | model.nonlinearequalities) & nargout>2
    allA = [model.Anonlineq;model.Anonlinineq];
    dg = [];    
    for i = 1:length(model.linearindicies)
        xevaled = zeros(1,length((model.c)));
        xevaled(model.linearindicies) = x;
        mt = model.monomtable;
        oldpower = mt(:,model.linearindicies(i));
        mt(:,model.linearindicies(i)) = mt(:,model.linearindicies(i))-1;
        xevaled = prod(repmat(xevaled,size(mt,1),1).^mt,2);
        xevaled = xevaled(:)'.*oldpower';xevaled(isnan(xevaled))=0;        
        dg = [dg allA*xevaled'];
    end
    if  model.nonlinearequalities
        dgeq = dg(1:size(model.Anonlineq,1),:);
        dgeq = dgeq';
    else
        dgeq = [];
    end
    if model.nonlinearinequalities
        dg = dg(size(model.Anonlineq,1)+1:end,:);
        dg = dg';
    else
        dg = [];
    end
else
    dg = [];
    dgeq = [];
end