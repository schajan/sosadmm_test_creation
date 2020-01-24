function [result,converged,tbuild,tsolve] = SOLVER_SOSTOOLS_SEDUMI(f,G,H)

p = f;

ineq=[];
for iii = 1 : length(G)
    ineq=[ineq; G{iii}] ;
end

eq=[];
for iii = 1 : length(H)
    eq=[eq; H{iii}] ;
end

%DEG = max([dObj dIneq dEq])+2;
DEG = 0;
solver_opt.solver = 'sedumi';
options = solver_opt;
fprintf('Why should the degree be max(dObj,dIneq,dEq)+2?\n')

% BUILDING STARTS HERE
tic

ineq = ineq(:);
eq = eq(:);
%             options.solver='sedumi';



vect = [p; ineq; eq];

% Find the independent variables, check the degree
if isa(vect,'sym')
    varschar = findsym(vect);
    vars = sym(['[',varschar,']']);
    nvars = size(vars,2) ;
    if nargin > 2
        degree = 2*floor(DEG/2);
        deg = zeros(length(vect),1);
        for i = 1:length(vect)
            deg(i) = double(feval(symengine,'degree',vect(i),converttochar(vars)));
            if deg(i) > degree
                %error('One of the expressions has degree greater than DEG.');
                degree = deg(i);
            end;
        end;
    else
        % Can change, to call maple only once.
        for var = 1:nvars;
            if rem(double(feval(symengine,'degree',p)),2) ;
                disp(['Degree in ' char(vars(var)) ' should be even. Otherwise the polynomial is unbounded.']);
                result = -Inf;
                xopt = [];
                return;
            end;
        end;
    end;
    syms gam;
    
else
    varname = vect.var;
    vars = [];
    for i = 1:size(varname,1)
        pvar(varname{i});
        vars = [vars eval(varname{i})];
    end;
    
    if nargin > 2
        degree = 2*floor(DEG/2);
        degmat = sum(vect.degmat,2);
        deg = zeros(length(vect),1);
        for i = 1:length(vect)
            idx = find(vect.coefficient(:,i));
            deg(i) = max(degmat(idx));
            if deg(i) > degree
                %error('One of the expressions has degree greater than DEG.');
                degree = deg(i);
            end;
        end;
    else
        deg = mod(max(p.degmat,[],1),2);
        if sum(deg)~=0
            i = find(deg~=0);
            disp(['Degree in ' varname{i(1)} ' should be even. Otherwise the polynomial is unbounded.']);
            result = -Inf;
            xopt = [];
            return;
        end;
    end;
    pvar gam;
end;

% Construct other valid inequalities
if length(ineq)>1
    for i = 1:2^length(ineq)-1
        Ttemp = dec2bin(i,length(ineq));
        T(i,:) = str2num(Ttemp(:))';
    end;
    T = T(find(T*deg(2:1+length(ineq)) <= degree),:);
    
    deg = [deg(1); T*deg(2:1+length(ineq)); deg(2+length(ineq):end)];
    for i = 1:size(T,1)
        ineqtempvect = (ineq.').^T(i,:);
        ineqtemp(i) = ineqtempvect(1);
        for j = 2:length(ineqtempvect)
            ineqtemp(i) = ineqtemp(i)*ineqtempvect(j);
        end;
    end;
    ineq = ineqtemp;
end;

prog = sosprogram(vars,gam);
expr = p-gam;
for i = 1:length(ineq)
    [prog,sos] = sossosvar(prog,monomials(vars,0:floor((degree-deg(i+1))/2)));
    expr = expr - sos*ineq(i);
end;
for i = 1:length(eq)
    [prog,pol] = sospolyvar(prog,monomials(vars,0:degree-deg(i+1+length(ineq))));
    expr = expr - pol*eq(i);
end;
prog = sosineq(prog,expr);
prog = sossetobj(prog,-gam);

tbuild = toc;

% SOLVING STARTS HERE
tic
[prog,info] = sossolve(prog,options);
tsolve = toc;

result = double(sosgetsol(prog,gam,16));
converged = 1-max(info.pinf,info.dinf);

end