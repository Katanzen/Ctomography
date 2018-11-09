function arrayOf = degreeToProjection(image, sensorArray, empitySpace, sizeOfImage, detectionSensors, numberOfSamples)
    %myFun - Description
    % Takes degree and image outputs the projection
    % Syntax: array = degreeToProjection(image, degree)

    % TODO: Find the degree And the equation of the every sensor ,
    % with m = (y-y1)/(x-x1); and tand(degree)

    % İnitializin required variables:
    degree = 0;
    slopeOfTheLineS = tand(degree);

    % Constant points of the lines are initialized in a two dimensional matrix
    % First row contains x posiitions second row contains y positions of the lines:
    originPoint = floor(sizeOfImage / 2);
    constPointsLines = ones(2, detectionSensors);
    for x = 1:detectionSensors
        constPointsLines(1, x) = sensorArray(x);
        constPointsLines(2, x) = 0;
    end

    disp(constPointsLines);

    arrayOf=zeros(1,detectionSensors);
    
    
    for i = 1:detectionSensors
        if(sensorArray(i) < empitySpace)
            disp("Executed here");
            arrayOf(i) = 0;
        
        elseif( sensorArray(i) > sensorArray(detectionSensors) - empitySpace)
            
            arrayOf(i) = 0;
            
        else
                for j=1:sizeOfImage
                    if(sensorArray(i)>j && sensorArray(i)<j+1)
                        for t=1:sizeOfImage
                            % disp(arrayOf(i));
                            % disp(i);
                            % disp(t);
                            arrayOf(i) = arrayOf(i) + image(j,t);
                    
                        end
                    end
                end
        end
    end
    
end