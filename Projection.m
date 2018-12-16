% Image initializition and parameter setting:
clc;
clear;
image = ones(4,4);
image(2,2) = 10;
image(2,3) = 10;
image(3,2) = 10;
image(3,3) = 10;
numberOfSamples = 180;
numberOfSamplesOnLines = 100;


%Size of the one dimension, assumes matrix is square:
sizeOfImage = size(image);
sizeOfImage = sizeOfImage(1);

% Sensors and length between them:
detectionSensors = 10;
lengthOfSensorPanel = sizeOfImage * sqrt(2);
lengthBetweenSensors = lengthOfSensorPanel / detectionSensors;

[projectionArray, backProjectedImage, filteredBackProjection] = degreeToProjection(image, sizeOfImage, detectionSensors, numberOfSamples, lengthOfSensorPanel, numberOfSamplesOnLines);


% backProjectedImage = backProjectedImage /(sizeOfImage* sqrt(2));
% disp(backProjectedImage);

% disp((filteredBackProjection));
figure;
subplot(2,2,1);
imagesc(image);
title("Image");
subplot(2,2,2);
imagesc(projectionArray);
title("Projection");
subplot(2,2,3);
imagesc(backProjectedImage);
title("BackProjected Image");
subplot(2,2,4);
imagesc(filteredBackProjection);
title("FilteredBackProjection Image");
