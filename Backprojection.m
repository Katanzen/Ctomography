% 
% 0 degree is okay look at the others
% 
function backProjectedImageRe = myFun(backProjectedImage, imagesize, projectionData, numberOfSamples, numberOfSamplesOnRays, numberofdetectors, degree, numberOfHitArray, reference_points, originPoint, indexForProjectionData)
  
  % disp(imagesize);
  samplearray = linspace(-originPoint, originPoint, 100);
  % degreeJump = 180 / numberOfSamples;
  % disp(imagesize);
  halfTheImageSize = imagesize / 2 ;
  % disp(numberOfHitArray);
  for k = 1:numberofdetectors
    % disp(degree);
    % disp(numberOfHitArray(1,k));
    numberOfHitsToSend = numberOfHitArray(1,k);
    % disp(numberOfHitsToSend);
    for i = 1:numberOfSamplesOnRays
      [xpoint, ypoint] = find_point_cordinates(reference_points(1, k), reference_points(2, k), samplearray(i), degree);
       calculateBackProjectionData(xpoint, ypoint, numberOfHitsToSend, k);
    end

  end

  function calculateBackProjectionData(xpoint_line, ypoint_line, numberOfHits, index)


    if(xpoint_line > -halfTheImageSize && xpoint_line < halfTheImageSize && ypoint_line > -halfTheImageSize && ypoint_line <halfTheImageSize)
      % disp(floor(xpoint_line));
      % disp(ypoint_line);
      % NUMBER OF HİTS AGAİN
      if(xpoint_line < 0)
        floredx = halfTheImageSize - floor(xpoint_line);
      else
        floredx = halfTheImageSize - floor(xpoint_line);
      end

      if(ypoint_line < 0)
        floredy = halfTheImageSize + ceil(ypoint_line);
      else 
        floredy = halfTheImageSize + ceil(ypoint_line);        
      end
      % if(floredx < originPoint)
      % disp(backProjectedImage(floredx, floredy));
      % disp(projectionData(floredx, floredy)/numberOfHits);
      % disp(numberOfHits);
      % if(numberOfHits == 0)
      %   disp(xpoint_line);
      %   disp(ypoint_line);

      % else
      % disp(floredx);
      backProjectedImage(floredx, floredy) =(projectionData(index, indexForProjectionData)/numberOfHits);

        % backProjectedImage(floredx, floredy) = 0;
      % end
    end
    % pdata = data; And here
  end

  backProjectedImageRe = backProjectedImage;
  
end