clear; clc;

suite = 'DenseConstraintsZeroFeas__N=10';

% Search in not calculated yet. Then move the folders to calculated
data_SOSTOOLS_SEDUMI = [];
header_SOSTOOLS_SEDUMI = {};

nProblems = 0;
directories = dir;
for i=1:length(directories)
    dire = directories(i).name;
    if startsWith(dire,['Poly_' suite])
        %movefile(dire,cpp_path);
        files = dir(dire);
        nProblems = nProblems + 1;
        
        header_SOSTOOLS_SEDUMI{end+1,1} = dire;
        
        for ii = 1:length(files)
            if endsWith(files(ii).name,'.mat')
                path = [dire '/' files(ii).name];
                load(path) % Contains Objects f,G,H
                
                [result,converged,tbuild,tsolve] = SOLVER_SOSTOOLS_SEDUMI(f,G,H);
                data_SOSTOOLS_SEDUMI = [data_SOSTOOLS_SEDUMI; [nProblems result converged 0 tbuild tsolve]];
            end
        end
        
        movefile(dire,'Calculated');
    end
end

savepath = ['Calculated/' suite '_matlab_meas'];
save(savepath,'header_SOSTOOLS_SEDUMI','data_SOSTOOLS_SEDUMI');
