function [freqArr, specArr, keysArr, tagArr, extrasArr] = read_csv_spec(files, calibrate)
    if nargin < 2
        calibrate = true;
    end
    first = true;
    
    for i = 1:length(files)
        file = files(i);
        lines = readlines(file);
        
        keysStart = find(~cellfun(@isempty, regexp(lines, '(?i)# *Keywords')), 1) + 1;
        tagsStart = find(~cellfun(@isempty, regexp(lines, '(?i)RDFTags')), 1) + 1;
        extrasStart = find(~cellfun(@isempty, regexp(lines, '(?i)RDFExtra *Tags')), 1) + 1;
        coldefStart = find(~cellfun(@isempty, regexp(lines, '(?i)# *Column *Definitions')), 1) + 1;
        dataStart = find(~cellfun(@isempty, regexp(lines, '(?i)# *Data')), 1) + 1;
        
        % --- KEYWORDS ---
        keywordLines = lines(keysStart : tagsStart-2);
        keywordDict = containers.Map('KeyType', 'char', 'ValueType', 'char');
        for k = 1:length(keywordLines)
            parts = strsplit(keywordLines(k), ',');
            if length(parts) >= 2
                keywordDict(strtrim(parts(1))) = strtrim(parts(2));
            end
        end
        
        % --- TAGS ---
        tagLines = lines(tagsStart : extrasStart-2);
        tagDict = containers.Map('KeyType', 'char', 'ValueType', 'any');
        for t = 1:length(tagLines)
            parts = strsplit(tagLines(t), ',');
            if length(parts) >= 3
                key = strtrim(parts(1));
                val = [str2double(parts(2)), str2double(parts(3))];
                tagDict(key) = val;
            end
        end
        
        % --- EXTRAS  ---
        extrasLines = lines(extrasStart : coldefStart-2);
        extrasDict = containers.Map('KeyType', 'char', 'ValueType', 'char');
        for e = 1:length(extrasLines)
            parts = strsplit(extrasLines(e), ',');
            if length(parts) >= 2
                extrasDict(strtrim(parts(1))) = strtrim(parts(2));
            end
        end
        
        data = readmatrix(file, 'NumHeaderLines', dataStart - 1);
        
        freq = data(:, 1);
        spec = data(:, 2:3)';
        
        if calibrate
            if isKey(tagDict, 'sdev')
                sdev = tagDict('sdev');
                spec(1,:) = spec(1,:) * sdev(1);
                spec(2,:) = spec(2,:) * sdev(2);
            else
                error('Calibration requested but no sdev in file %s, quitting', file);
            end
        end
        
        if first
            freqArr = freq';
            specArr = spec;
            keysArr = {keywordDict};
            tagArr = {tagDict};
            extrasArr = {extrasDict};
            first = false;
        else
            freqArr = [freqArr; freq']; 
            specArr = cat(3, specArr, spec); 
            keysArr{end+1} = keywordDict;
            tagArr{end+1} = tagDict;
            extrasArr{end+1} = extrasDict;
        end
    end
end