function [C, Y] = data_labeling(x, labelName)
%DATA_LABELING 
%   Each segment is treated as an observation
%   Each sensor is treated as a feature
%   x is the data
%   labelName is the label name
%   C and Y are to be used by trainNetwork
%   C is the time series data
%   Y is the categorical labels
    nSegments = size(x, 3); 
    C = cell(nSegments, 1);
    for segment = 1 : nSegments
        C(segment, 1) = {x(:, :, segment)'};
    end
    Y = categorical(zeros(nSegments, 1), 0, {labelName});
end