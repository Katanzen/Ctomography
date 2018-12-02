function [arrayOf, backProjectedImageRe] = degreeToProjection(image, sizeOfImage, detectionSensors, numberOfSamples, lengthOfSensorPanel,numberOfSamplesOnLines)


    %myFun - Description
    % Takes degree and image outputs the projection
    % Syntax: array = degreeToProjection(image, degree)

    % TODO: Find the degree And the equation of the every sensor ,
    % with m = (y-y1)/(x-x1); and tand(degree)

    % İnitializin required variables:
    % arrayOf=zeros(numberOfSamples,detectionSensors); %initializing the return array.
    distanceBetweenSensorLines = lengthOfSensorPanel / detectionSensors; %Distance between the sensor lines.
    originPoint = lengthOfSensorPanel/2;
    distanceFromOrigin = zeros(0, detectionSensors);
    % backProjectedImageRe = zeros(sizeOfImage, sizeOfImage);

    degreeJump = floor(180/numberOfSamples);
    discretePointsInLines = 100;
    projectionLinesLength = sizeOfImage*sqrt(2);
    discrete_point_jump = projectionLinesLength / discretePointsInLines;
    constPointsLinesForZero = zeros(2, detectionSensors);
    projectiondata = ones(detectionSensors, numberOfSamples);
    % Constant points of the lines are initialized in a two dimensional matrix
    % First row contains x posiitions second row contains y positions of the lines:



    % Constant x points for 0 degree
    indexForProjectionData = 1;
    backProjectedImage = zeros(sizeOfImage, sizeOfImage);
    for degree = 0:degreeJump:179
        % disp(degree);
        referencePoints = findConstPointLines(degree);
        [projectiondata(:,indexForProjectionData), numberOfHitArray] = calculateProjection(image, referencePoints, degree, numberOfSamplesOnLines, detectionSensors, projectionLinesLength, originPoint, numberOfSamples);
        % figure
        % plot(projectiondata);
        % disp(degree);
        % disp(projection);
        % disp(numberOfHitArray);
        % disp(-6 * distanceBetweenSensorLines + originPoint);
        backProjectedImageRe = Backprojection(backProjectedImage, sizeOfImage, projectiondata, numberOfSamples, numberOfSamplesOnLines, detectionSensors, degree, numberOfHitArray, referencePoints, originPoint, indexForProjectionData);
        indexForProjectionData = indexForProjectionData + 1;

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

        if(degree>=1 && degree<180)
            for p = 1: detectionSensors
                [new_refence_points(1, p), new_refence_points(2,p)] = calculate_new_reference_points(degree, p);
                returnArray =  new_refence_points;
            end
        end
                
    end

    
    function [newArrayOfReferences1, newArrayOfReferences2] = calculate_new_reference_points(takeDegree, index)
        newArrayOfReferences1 =  distanceFromOrigin(index) * cosd(takeDegree);
        newArrayOfReferences2 = -distanceFromOrigin(index) * sind(takeDegree);

    end
    % disp(distanceFromOrigin);

end


% 
% 
%  FORWARD PROBLEM İS OVER NİCEE
% 
% 