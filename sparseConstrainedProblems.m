function sparseConstrainedProblems(N,dObj,nPoly,nIneq,dIneq,nEq,dEq,k,nProblems)

folderName = ['SparseConstraintsZeroFeas_' '_N=' num2str(N) '_dObj=' num2str(dObj) '_nPoly=' num2str(nPoly) '_nIneq=' num2str(nIneq) '_dIneq=' num2str(dIneq) '_nEq=' num2str(nEq) '_dEq=' num2str(dEq) '_k=' num2str(k)];
mkdir(folderName)

for i=1:nProblems
    problemName = strcat('SparseProblem_',num2str(i),'_N=',num2str(N));
    [f,G,H] = constrainedSparsityTest_AI(N,dObj,nPoly,nIneq,dIneq,nEq,dEq,k);
    polyToFile(f,G,H,folderName,problemName)
end

end