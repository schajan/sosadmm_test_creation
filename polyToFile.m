function polyToFile(f,G,H,folderName,problemName)

filename = problemName;
diary(strcat(filename,'_temp'));

f
fprintf('END_EQ\n')
for i=1:length(G)
    g = G{i}
    fprintf('END_EQ\n')
end

for i=1:length(H)
    h = H{i}
    fprintf('END_EQ\n')
end

fprintf('ENDOFFILE')

diary off;

% Clean the file
fid = fopen(strcat(filename,'_temp'));
ftarget = fopen(filename,'wt');

while true
    line = fgetl(fid);
    
    if startsWith(line,'ENDOFFILE')
        break;
    end
    
    if isempty(strcat(line,line))
        continue;
    end
    
    if startsWith(line,'f') || startsWith(line,'g') || startsWith(line,'h')
        eq = read_equation(fid,line);
        eq = clean_equation(eq);
        fprintf(ftarget,'%s\n',eq);
    end
    
end

fclose(fid);
delete(strcat(filename,'_temp'));
fclose(ftarget);
movefile(filename,folderName);
end
