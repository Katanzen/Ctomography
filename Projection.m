% Image initializition and parameter setting:
clc;
clear;
image = ones(12,12);
image(4,3) = 10;
image(4,4) = 10;
image(5,3) = 10;
image(5,4) = 10;
numberOfSamples = 180;
detectionSensors = 200;

%Size of the one dimension, assumes matrix is square:
sizeOfImage = size(image);
sizeOfImage = sizeOfImage(1);

% Sensors and length between them:
numberOfSamplesOnLines = 100;
lengthOfSensorPanel = sizeOfImage * sqrt(2);
lengthBetweenSensors = lengthOfSensorPanel / detectionSensors;

[projectionArray, backProjectedImage, filteredBackProjection] = degreeToProjection(image, sizeOfImage, detectionSensors, numberOfSamples, lengthOfSensorPanel, numberOfSamplesOnLines);


backProjectedImage = backProjectedImage /(sizeOfImage* sqrt(2));
% disp(backProjectedImage);
%   for i=1:10
%         highPassFilter(1,i) = i*i*i;
%   end
%   for m=1:10
%     filteredBackProjection(m,:)= (real(ifft(fftshift(fft(filteredBackProjection(m,:))).* highPassFilter)));
%   end
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
