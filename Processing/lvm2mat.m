fc = 50;
inputFolder = '../OTDR Data/';
outputFolder = '../Labeled Data/';
mkdir(outputFolder);
listing = dir([inputFolder, '*.lvm']);
for i = 1 : length(listing)
    fileName = listing(i).name;
    path = [inputFolder, fileName];
    labelName = fileName(1 : end - 4);
    y = data_import(path);
    z = data_filtering(y, fc);
    [C, Y] = data_labeling(z, labelName);
    save([outputFolder, labelName '.mat'], 'C', 'Y'); 
end

