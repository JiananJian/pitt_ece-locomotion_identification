%%
fc = 100;
folderName = '../OTDR Data/';
outputFolder = '../Labeled_Data/';
mkdir(outputFolder);
listing = dir([folderName, '*.lvm']);
for i = 1 : length(listing)
    fileName = listing(i).name;
    path = [folderName, fileName];
    labelName = fileName(1 : end - 4);
    y = data_import(path);
    z = data_filtering(y, fc);
    [C, Y] = data_labeling(z, labelName);
    save([outputFolder, labelName '.mat'], 'C', 'Y'); 
end

%%
labelName = 'jingyi-walk';
fileName = '../OTDR Data/jingyi-walk.lvm';
y = data_import(fileName);
z = data_filtering(y, fc);
[C1, Y1] = data_labeling(z, labelName);
save([labelName '.mat'], C1, Y1); 

labelName = 'run-jingyu';
fileName = '../OTDR Data/run-jingyu.lvm';
y = data_import(fileName);
z = data_filtering(y, fc);
[C2, Y2] = data_labeling(z, labelName);

labelName = 'car';
fileName = '../OTDR Data/car.lvm';
y = data_import(fileName);
z = data_filtering(y, fc);
[C3, Y3] = data_labeling(z, labelName);

labelName = 'run-wen';
fileName = '../OTDR Data/run-wen.lvm';
y = data_import(fileName);
z = data_filtering(y, fc);
[C4, Y4] = data_labeling(z, labelName);

labelName = 'walk1';
fileName = '../OTDR Data/walk1.lvm';
y = data_import(fileName);
z = data_filtering(y, fc);
[C5, Y5] = data_labeling(z, labelName);

labelName = 'walk2';
fileName = '../OTDR Data/walk2.lvm';
y = data_import(fileName);
z = data_filtering(y, fc);
[C6, Y6] = data_labeling(z, labelName);

labelName = 'run-two people';
fileName = '../OTDR Data/run-two people.lvm';
y = data_import(fileName);
z = data_filtering(y, fc);
[C7, Y7] = data_labeling(z, labelName);

%%
index1 = ceil(rand(39, 1)*196);
index3 = ceil(rand(39, 1)*75);
C = [C1(index1); C2; C3(index3)];
Y = [Y1(index1); Y2; Y3(index3)];

%%
inputSize = 5; 
outputSize = 60;
outputMode = 'last';
numClasses = 3;

layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(outputSize,'OutputMode',outputMode)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

maxEpochs = 150;
miniBatchSize = 5;
shuffle = 'once';

options = trainingOptions('sgdm', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'Shuffle', shuffle);

net = trainNetwork(C,Y,layers,options);

%%

disp(' ');
XTest = C5;
YPred = classify(net,XTest, ...
    'MiniBatchSize', miniBatchSize);
disp('Prediction:');
summary(YPred);
disp('Reality:');
summary(Y5);