function show_data(freq, spec, klucze_meta, tags, extras)
    disp('--- Data sumarise ---');
    
    fprintf('Freq range: %e -- %e Hz\n', min(freq(:)), max(freq(:)));
    
    dimsSpec = size(spec);
    fprintf('Dimentions of spec: %d rows x %d columns x %d pages\n', dimsSpec(1), dimsSpec(2), size(spec, 3));
    
    fprintf('Numbr of files: %d\n', length(klucze_meta));
    
    FirstTagDict = tags{1};
    numOfTags = FirstTagDict.Count;
    fprintf('First file has %d informations in TAGS section\n', numOfTags);
    
    disp('---------------------------');
end