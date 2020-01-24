function [p,g,h] = constrainedSparsityTest_AI(N,dObj,nPoly,nIneq,dIneq,nEq,dEq,k)


for iii = 1 : N

     N_var{iii, 1}= strcat('x_', num2str(iii));

    end
    
x_var = polynomial(N_var);


% Objective creation
% b  = mmon(x_var,0,floor(dObj/2));
b  = monomials(x_var,0:floor(dObj/2));    % degree up tp 2d - 1;

p = 0;
for i=1:nPoly
    coeff = randn(1,length(b));
    coeff(1) = 0;
    pi = (coeff*b)^2;
    p = p + pi;
end




% for iii = 1 : k
% 
%      N_var{iii, 1}= strcat('x_', num2str(iii));
% 
%     end
%     
% x_var_k = polynomial(N_var);
% 

% mpol('v',k,1);


% Inequality Constraints gi >= 0
% b = mmon(v,0,dIneq);
% b  = monomials(x_var_k,0:dIneq);    % degree up tp 2d - 1;
b  = monomials(x_var(1:k),0:dIneq);    % degree up tp 2d - 1;

for i=1:nIneq
    coeff = randn(1,length(b));
    coeff(1) = 1;
    g{i} = coeff*b;
end

% Equality Constraints hi == 0
% b = mmon(v,0,dEq);
% b  = monomials(x_var_k,0:dEq);    % degree up tp 2d - 1;
b  = monomials(x_var(1:k),0:dEq);    % degree up tp 2d - 1;

for i=1:nEq
    coeff = randn(1,length(b));
    coeff(1) = 0;
    h{i} = coeff*b;
end

end