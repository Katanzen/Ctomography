% image initializition and parameter setting:
clc;
clear;
image = ones(4,4);
image(4,1) = 2;
% disp(image(2,:));
% disp(image(:,2));
numberOfSamples = 180;
numberOfSamplesOnLines = 100;


%Size of the one dimension assumes matrix is square:
sizeOfImage = size(image);
sizeOfImage = sizeOfImage(1);

% Sensors and length between them:
detectionSensors = 10;
lengthOfSensorPanel = sizeOfImage * sqrt(2);
lengthBetweenSensors = lengthOfSensorPanel / detectionSensors;

[projectionArray, backProjectedImage] = degreeToProjection(image, sizeOfImage, detectionSensors, numberOfSamples, lengthOfSensorPanel, numberOfSamplesOnLines);
% figure;
disp(projectionArray);
disp(image);
% plot(image);
% figure;
disp(backProjectedImage);
% plot(backProjectedImage);
% 
% plot(projectionArray(:,1));
% figure;
% plot(projectionArray(:,2));
% figure;
% plot(projectionArray(:,3));
% figure;
% plot(projectionArray(:,4));