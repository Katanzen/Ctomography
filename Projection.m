% Image initializition and parameter setting:
clc;
clear;
image = ones(4,4);
image(2,2) = 10;
numberOfSamples = 179;
numberOfSamplesOnLines = 100;


%Size of the one dimension, assumes matrix is square:
sizeOfImage = size(image);
sizeOfImage = sizeOfImage(1);

% Sensors and length between them:
detectionSensors = 10;
lengthOfSensorPanel = sizeOfImage * sqrt(2);
lengthBetweenSensors = lengthOfSensorPanel / detectionSensors;

[projectionArray, backProjectedImage] = degreeToProjection(image, sizeOfImage, detectionSensors, numberOfSamples, lengthOfSensorPanel, numberOfSamplesOnLines);
% figure;
% disp(projectionArray);
disp(image);
% plot(image);
% figure;
backProjectedImage = backProjectedImage /(sizeOfImage*4.150*numberOfSamples * sqrt(2));
disp(backProjectedImage);
hpassFilter = ones(3,3);
hpassFilter(2,2) = 10000;
disp(hpassFilter);
disp(conv2(backProjectedImage, hpassFilter, "same")/5);
% disp(edge(backProjectedImage,"canny"));
% plot(backProjectedImage);
% 
% plot(projectionArray(:,1));
% figure;
% plot(projectionArray(:,2));
% figure;
% plot(projectionArray(:,3));
% figure;
% plot(projectionArray(:,4));