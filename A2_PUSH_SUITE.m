
suite = 'DenseConstraints';

directories = dir;
cpp_path = '/Users/janschappi/CLionProjects/sosadmm_bolt/sosadmm_bolt_cp/problems/MATLAB_Samples';
for i=1:length(directories)
    dire = directories(i).name;
    if startsWith(dire,suite)
        movefile(dire,cpp_path);
    end
end