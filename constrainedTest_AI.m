function [p,g,h] = constrainedTest_AI(N,dObj,nPoly,nIneq,dIneq,nEq,dEq)

% mpol('v',N,1); 

for iii = 1 : N

     N_var{iii, 1}= strcat('x_', num2str(iii));

    end
    
x_var = polynomial(N_var);


b  = monomials(x_var,0:floor(dObj/2));    % degree up tp 2d - 1;

% Objective creation
% b  = mmon(v,0,floor(dObj/2));
p = 0;
for i=1:nPoly
    coeff = randn(1,length(b));
    coeff(1) = 0;
    pi = (coeff*b)^2;
    p = p + pi;
end

% Inequality Constraints gi >= 0
% b = mmon(v,0,dIneq);

b  = monomials(x_var,0:dIneq);    % degree up tp 2d - 1;

for i=1:nIneq
    coeff = randn(1,length(b));
    coeff(1) = 1;
    g{i} = coeff*b;
end

% Equality Constraints hi == 0
% b = mmon(v,0,dEq);
b  = monomials(x_var,0:dEq);    % degree up tp 2d - 1;

for i=1:nEq
    coeff = randn(1,length(b));
    coeff(1) = 0;
    h{i} = coeff*b;
end