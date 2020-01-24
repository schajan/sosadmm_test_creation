function elements = parseCSVLine(line)

    last = strfind(line,'|');
    commas = strfind(line(1:last),',');
    
    commas = [0 commas last];
    elements = {};
    
    for i=1:length(commas)-1
        start = commas(i)+1;
        ending = commas(i+1)-1;
        elements{i} = line(start:ending);
    end
end