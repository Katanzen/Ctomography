function [arrayOf, backProjectedImageRe, filteredBackProjectionRe] = degreeToProjection(image, sizeOfImage, detectionSensors, numberOfSamples, lengthOfSensorPanel,numberOfSamplesOnLines)
    %myFun - Description
    % Takes degree and image outputs the projection
    % Syntax: array = degreeToProjection(image, degree)

    % TODO: Find the degree And the equation of the every sensor ,
    % with m = (y-y1)/(x-x1); and tand(degree)

    % Initializition of required variables:
    % arrayOf=zeros(numberOfSamples,detectionSensors); %initializing the return array.
    distanceBetweenSensorLines = lengthOfSensorPanel / detectionSensors; %Distance between the sensor lines.
    originPoint = lengthOfSensorPanel/2;
    distanceFromOrigin = zeros(0, detectionSensors);
    % backProjectedImageRe = zeros(sizeOfImage, sizeOfImage);
    
    highPassFilter = ones(1,detectionSensors);
    lowPassFilter = ones(1,detectionSensors);
%     highPassFilter(:,1) = [1, 1, 2, 3, 4.5, 4.5, 3, 2, 1, 1];
%     highPassFilter(:,1) = [5, 3, 2, 1,1,1, 1, 2, 3, 5];
%     highPassFilter(:,1) = [1,2,3,4,5,6,7,8,9,10];
%     for i=1:detectionSensors
%         if(i<=(detectionSensors/2))
%             highPassFilter(i,1) =  highPassFilter(i,1) * detectionSensors/(i);
%         else
%             highPassFilter(i,1) =  highPassFilter((detectionSensors + 1 - i),1);
%         end
%     end
%     for i=1:detectionSensors
%         if(i<=(detectionSensors/2))
%             highPassFilter(i) = 1 + i/100;
%         else
%             highPassFilter(i) = highPassFilter(i-(detectionSensors/2));
%         end
%     end
    for i=1:detectionSensors
%         disp(floor(detectionSensors/4));
        if(i>=ceil(detectionSensors/4) && i<=ceil(detectionSensors/2))
%             disp(i);
            highPassFilter(i) = 1 + 2.7*i;
        elseif(i> ceil(detectionSensors/2) && i<=(ceil(3*detectionSensors/4) + 1))
%             disp();
            highPassFilter(i) = highPassFilter( 2*ceil(detectionSensors/2) - i);
        end
%         highPassFilter(1,i) = 1 + i/100;
%         lowPassFilter(1,i) = 1;
        
    end
%     disp(highPassFilter);
%     disp(lowPassFilter);
%     highPassFilter(1,1) = 1;
%     highPassFilter(10,1) = 1;
%     disp(highPassFilter);    
%     highPassFilter = linspace(1,3,10);

    degreeJump = floor(180/numberOfSamples);
    discretePointsInLines = 100;
    projectionLinesLength = sizeOfImage*sqrt(2);
    discrete_point_jump = projectionLinesLength / discretePointsInLines;
    constPointsLinesForZero = zeros(2, detectionSensors);
    projectiondata = ones(detectionSensors, numberOfSamples);
    dataForFiltering = ones(detectionSensors, 1);
    % Constant points of the lines are initialized in a two dimensional matrix
    % First row contains x posiitions second row contains y positions of the lines:



    % Constant x points for 0 degree
    indexForProjectionData = 1;
    backProjectedImage = zeros(sizeOfImage, sizeOfImage);
    filteredBackProjectedImage = zeros(sizeOfImage, sizeOfImage);
    for degree = 0:degreeJump:179
        referencePoints = findConstPointLines(degree);
        [projectiondata(:,indexForProjectionData), numberOfHitArray] = calculateProjection(image, referencePoints, degree, numberOfSamplesOnLines, detectionSensors, projectionLinesLength, originPoint, numberOfSamples);
        dataForFiltering(:, 1) = projectiondata(:,indexForProjectionData);
%         disp(dataForFiltering);
        backProjectedImage = Backprojection(backProjectedImage, sizeOfImage, projectiondata, numberOfSamples, numberOfSamplesOnLines, detectionSensors, degree, numberOfHitArray, referencePoints, originPoint, indexForProjectionData, lowPassFilter);
        backProjectedImageRe = backProjectedImage;
        filteredBackProjectedImage =Filteredbackprojection(filteredBackProjectedImage, sizeOfImage, dataForFiltering, numberOfSamples, numberOfSamplesOnLines, detectionSensors, degree, numberOfHitArray, referencePoints, originPoint, indexForProjectionData, highPassFilter);
        filteredBackProjectionRe = filteredBackProjectedImage;
        indexForProjectionData = indexForProjectionData + 1;
%         disp(dataForFiltering);
        dataForFiltering(:,1) = 0;
        
    end
    
    arrayOf = projectiondata;




    function returnArray = findConstPointLines(degree)
        new_refence_points = zeros(2, detectionSensors);
        if(degree == 0)

            for o = 1:detectionSensors  
                if(((o-1) * distanceBetweenSensorLines) < originPoint)

                    constPointsLinesForZero(1,o) = originPoint - (o-1)*distanceBetweenSensorLines;
                    distanceFromOrigin(o) = (constPointsLinesForZero(1, o));
                else
                    constPointsLinesForZero(1, o) = originPoint - (o-1)*distanceBetweenSensorLines;
                    distanceFromOrigin(o) = (constPointsLinesForZero(1, o));

                end
                constPointsLinesForZero(2,o) = 0;
            end

            returnArray = constPointsLinesForZero;
        end

        if(degree>=1 && degree<91)
            for p = 1: detectionSensors
                [new_refence_points(1, p), new_refence_points(2,p)] = calculate_new_reference_points(degree, p);
                returnArray =  new_refence_points;
%                 disp(new_refence_points);
            end
        end
        
        if(degree > 90)
             for p = 1: detectionSensors
                [new_refence_points(1, p), new_refence_points(2,p)] = calculate_new_reference_points(degree, p);
                returnArray =  new_refence_points;
%                 disp(new_refence_points);
             end
        end
                
    end

    
    function [newArrayOfReferences1, newArrayOfReferences2] = calculate_new_reference_points(takeDegree, index)
        if(degree <= 90)
        newArrayOfReferences1 =  distanceFromOrigin(index) * cosd(takeDegree);
        newArrayOfReferences2 = -distanceFromOrigin(index) * sind(takeDegree);
        end
        if(degree>90)
%             disp(distanceFromOrigin(index));
            newArrayOfReferences1 = -distanceFromOrigin(index) * cosd(180-takeDegree);
            newArrayOfReferences2 = -distanceFromOrigin(index) * sind(180-takeDegree);
%             disp(newArrayOfReferences1);
        end
    end
    % disp(distanceFromOrigin);

end


% 
% 
%  FORWARD PROBLEM IS OVER NICEEE
% 
% 