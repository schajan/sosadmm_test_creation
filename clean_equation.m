function eq = clean_equation(eq)
    eq = strrep(eq,' ','');
    eq = strrep(eq,'*','');
    eq = strrep(eq,'=','');
    eq = strrep(eq,'_','');
    eq = [eq(1) ' ' eq(2:end)];
end