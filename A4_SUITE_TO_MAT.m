clear;clc

suite = 'DenseConstraintsZeroFeas__N=10';

% Struct with two members: Header (for every line 3 descriptions) and Data
% (a Matrix with the results)
tableName = [suite '_cpp_meas'];
directories = dir('Calculated');
header = {};
data = [];
nProblems = 0;
for iii=1:length(directories)
    dire = directories(iii).name;
    if startsWith(dire,suite)
        
        nProblems = nProblems + 1;
        
        % Read in the cpp_meas file
        fid = fopen(['Calculated/' dire '/cpp_meas.txt']);
        while true
            line = fgetl(fid);
            if ~ischar(line)
                break;
            end
            
            if startsWith(line,'Directory') 
                header{nProblems,1} = line;
            elseif startsWith(line,'Parameters')
                header{nProblems,2} = line;
            elseif startsWith(line,'Result')
                header{nProblems,3} = ['ExperimentNumber,',line];
            else
                elements = parseCSVLine(line);
                a = zeros(1,6);
                a(1) = nProblems;
                for ii = 1:5
                    a(ii+1) = str2num(elements{ii});
                end
                data = [data; a];
            end
        end
        fclose(fid);
    end
end

save(['Calculated/' tableName],'header','data');
