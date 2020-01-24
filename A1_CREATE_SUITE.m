clear
clc

for nIneq =2:20
    N = 10; dObj = 2; nPoly = 3; dIneq = 2; nEq = 5; dEq = 3;
    nProblems = 20;

    %N,dObj,nPoly,nIneq,dIneq,nEq,dEq,k,nProblems
    denseConstrainedProblems(N,dObj,nPoly,nIneq,dIneq,nEq,dEq,nProblems);
end