% image initializition and parameter setting:
image = ones(4,4);
image(2,2) = 2;
numberOfSamples = 2;

%Size of the one dimension assumes matrix is square:
sizeOfImage = size(image);
sizeOfImage = sizeOfImage(1);

% Sensors and length between them:
detectionSensors = 10;
lengthOfSensorPanel = sizeOfImage * sqrt(2);
empitySpace = (lengthOfSensorPanel-sizeOfImage) / 2;
lengthBetweenSensors = lengthOfSensorPanel / detectionSensors;
sensorArray = (detectionSensors);

%Setting the place of the sensors on the sensorpanel
for i=1:detectionSensors
    sensorArray(i) = lengthBetweenSensors*(i); 
end

% Testing with 0 degree
projectionArray = degreeToProjection(image, sensorArray, empitySpace, sizeOfImage, detectionSensors, numberOfSamples, lengthOfSensorPanel);

plot(projectionArray);