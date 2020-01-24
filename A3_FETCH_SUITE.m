
suite = 'DenseConstraints';

cpp_path = '/Users/janschappi/CLionProjects/sosadmm_bolt/sosadmm_bolt_cp/problems/MATLAB_Samples';
here = pwd;
directories = dir(cpp_path);
for i=1:length(directories)
     dire = directories(i).name;
     if startsWith(dire,suite)
         movefile(strcat(cpp_path,'/',dire),strcat(here,'/Calculated'));
     end
end