function p = build_recursive_scheme(p);

p.evaluation_scheme = [];
p.monomials = find(p.variabletype);

if ~isempty(p.evalMap)
    
    % Figure out arguments in all polynomials & sigmonials
    for i = 1:length(p.monomials)
        p.monomialMap{i}.variableIndex = find(p.monomtable(p.monomials(i),:));
    end
    
    remainingEvals  = ones(1,length(p.evalVariables));
    remainingMonoms = ones(1,length(p.monomials));
    p = recursive_call(p,remainingEvals,remainingMonoms);

elseif any(p.variabletype)

    % Only polynomials
    p.evaluation_scheme{1}.group = 'monom';
    p.evaluation_scheme{1}.variables = 1:nnz(p.variabletype);

end

function p = recursive_call(p,remainingEvals,remainingMonoms)

if ~any(remainingEvals) & ~any(remainingMonoms)
    return
end

% Yep, this code can be sped up significantly...

% Extract arguments in first layer
if any(remainingEvals)
    for i = 1:length(p.evalMap)
        composite_eval_expression(i) = any(ismember(p.evalMap{i}.variableIndex,p.evalVariables(find(remainingEvals))));
        composite_eval_expression(i) = composite_eval_expression(i) | any(ismember(p.evalMap{i}.variableIndex,p.monomials(find(remainingMonoms))));
    end
end

if any(remainingMonoms)
    for i = 1:length(p.monomials)
        composite_monom_expression(i) = any(ismember(p.monomialMap{i}.variableIndex,p.monomials(find(remainingMonoms))));
        composite_monom_expression(i) = composite_monom_expression(i) | any(ismember(p.monomialMap{i}.variableIndex,p.evalVariables(find(remainingEvals))));
    end
end

% Bottom layer
if ~isempty(p.monomials) & any(remainingMonoms)
    if ~isempty(find(~composite_monom_expression & remainingMonoms))
        p.evaluation_scheme{end+1}.group = 'monom';
        p.evaluation_scheme{end}.variables = find(~composite_monom_expression & remainingMonoms);
    end
    remainingMonoms = composite_monom_expression & remainingMonoms;
end

% Bottom layer
if ~isempty(p.evalMap) & any(remainingEvals)
    if ~isempty(find(~composite_eval_expression & remainingEvals));
        p.evaluation_scheme{end+1}.group = 'eval';
        p.evaluation_scheme{end}.variables = find(~composite_eval_expression & remainingEvals);
    end
    remainingEvals = composite_eval_expression & remainingEvals;
end

p = recursive_call(p,remainingEvals,remainingMonoms);