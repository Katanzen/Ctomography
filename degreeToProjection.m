function arrayOf = degreeToProjection(image, degree, sensorArray, empitySpace, sizeOfImage, detectionSensors)
    %myFun - Description
    % Takes degree and image outputs the projection
    % Syntax: array = degreeToProjection(image, degree)
    %
    % Long description

    
    
    
    % detectionSensors = size(sensorArray);
    % disp(detectionSensors);
    % array = (detectionSensors);
    % disp(size(image));
    
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


    
end