function y = data_import(fileName)
%DATA_IMPORT
%   fileName is the path of the lvm file 
%   y has three dimensions:
%   the 1st is time in a second;
%   the 2nd is sensor;
%   the 3rd is segment.
    data = lvm_import(fileName, 0);
    names = fieldnames(data);
    segfind = strfind(names, 'Segment');
    index = find([segfind{:}] == 1);
    [~, nSegments] = size(index);

    for i = 1 : nSegments
        na = ['Segment', num2str(i)];
        value = data.(na);
        y(:, :, i) = value.data;
    end

end
