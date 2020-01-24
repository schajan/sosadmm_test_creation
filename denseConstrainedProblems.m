function denseConstrainedProblems(N,dObj,nPoly,nIneq,dIneq,nEq,dEq,nProblems)

folderName = ['DenseConstraintsZeroFeas_' '_N=' num2str(N) '_dObj=' num2str(dObj) '_nPoly=' num2str(nPoly) '_nIneq=' num2str(nIneq) '_dIneq=' num2str(dIneq) '_nEq=' num2str(nEq) '_dEq=' num2str(dEq)];
polyFolderName = ['Poly_' folderName];
mkdir(folderName)
mkdir(polyFolderName);

for i=1:nProblems
    problemName = strcat('DenseProblem_',num2str(i),'_N=',num2str(N));
    [f,G,H] = constrainedTest_AI(N,dObj,nPoly,nIneq,dIneq,nEq,dEq);
    save([polyFolderName '/' problemName],'f','G','H');
    polyToFile(f,G,H,folderName,problemName)
end

end