% image initializition and parameter setting:
image = ones(4,4);
image(2,2) = 2;
% disp(image(2,:));
% disp(image(:,2));
numberOfSamples = 2;
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
% disp(projectionArray);
disp(image);
% plot(image);
% figure;
disp(backProjectedImage);
% plot(backProjectedImage);

% plot(projectionArray);