function arrayOf = degreeToProjection(image, sensorArray, empitySpace, sizeOfImage, detectionSensors, numberOfSamples, lengthOfSensorPanel)


    %myFun - Description
    % Takes degree and image outputs the projection
    % Syntax: array = degreeToProjection(image, degree)

    % TODO: Find the degree And the equation of the every sensor ,
    % with m = (y-y1)/(x-x1); and tand(degree)

    % İnitializin required variables:
    arrayOf=zeros(numberOfSamples,detectionSensors); %initializing the return array.
    degreeStart = 0;
    
    distanceBetweenSensorLines = lengthOfSensorPanel / detectionSensors; %Distance between the sensor lines.
    % slopeOfTheLineS = tand(degree);
    originPoint = lengthOfSensorPanel*sqrt(2)/2;
    % originPoint = originPoint / 2;
    degreeJump = floor(180/numberOfSamples);
    discretePointsInLines = 100;
    projectionLinesLength = sizeOfImage*sqrt(2);
    discrete_point_jump = projectionLinesLength / discretePointsInLines;
    line_array = initializeLineArray();
    % Constant points of the lines are initialized in a two dimensional matrix
    % First row contains x posiitions second row contains y positions of the lines:


    % Constant x points for 0 degree
    for degree = 0:degreeJump:0
        referencePoints = findConstPointLines(degree);
        disp(referencePoints);
    end


    % TODO initialize array points but first you need to find the new reference points of the lines
    function line_array = initializeLineArray()
        double point;
        line_array = zeros(1, discretePointsInLines);
        for j = 1:discretePointsInLines
            point = j * discrete_point_jump;
            line_array(1, j) = point;
            
        end   
    end

    function returnArray = findConstPointLines(degree)
        if(degree == 0)
            constPointsLines = zeros(2, detectionSensors);

            %       TODO             
            %       İnitialize the array sensor lines reference points according to the degree.

            returnArray = constPointsLines;
        end
    end


    % disp(xPositionsLines);
end


% for i = 1:detectionSensors
%     % disp(i);
% xPosition = constPointsLines(1, i);
% yPosition = constPointsLines(2, i);

% % disp(xPosition);

% if(xPosition<originPoint)
%     % disp(xPosition);
%     xPosition = originPoint - xPosition;
%     if(xPosition<0.0001)
%         xPosition = 0;
%     end
%     % x1 = xPosition - yPosition -slope;
%     % disp(xPosition);

% else
%     xPosition = -1*(xPosition - originPoint);
%     % x1 = xPosition - yPosition -slope;
%     if(xPosition<0.0001 && xPosition> - 0.00001)
%         xPosition = 0;
%     end
%     % disp(xPosition);
% end
% constPointsLines(1,i) = xPosition;
