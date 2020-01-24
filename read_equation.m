function eq = read_equation(fid,firstLine)
% Will only be called if starts with f,g, or h
eq = firstLine;
while true
    line = fgetl(fid);
    if startsWith(line,'END_EQ')
        return
    end
    eq = strcat(eq,line);
end