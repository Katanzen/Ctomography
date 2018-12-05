% 
% 0 degree is okay look at the others
% 
function backProjectedImageRe = Backprojection(backProjectedImage, imagesizeR, projectionData, numberOfSamples, numberOfSamplesOnRays, numberofdetectors, degree, numberOfHitArray, reference_points, originPoint, indexForProjectionData)
  
  % disp(imagesizeR);
  samplearray = linspace(-originPoint, originPoint, 100);
  % degreeJump = 180 / numberOfSamples;
  % disp(imagesizeR);
  halfTheImageSize = imagesizeR / 2 ;
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
    
%     disp(floredxRe);
%     if(degree ~= 0 && floredxRe~=0 && floredyRE ~= 0)
%        backProjectedImage(floredxRe, floredyRE) = backProjectedImage(floredxRe, floredyRE) / numberOfHits;
%         % backProjectedImage(floredx, floredy) = 0;
%         print(numberOfHits);
%     end
  end

    function calculateBackProjectionData(xpoint_line, ypoint_line, numberOfHits, index)
%     floredx = 0;
%     floredy = 0;
    
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
%       floredx = floredx;
%       floredy = floredy;
      % if(floredx < originPoint)
      % disp(backProjectedImage(floredx, floredy));
      % disp(projectionData(floredx, floredy)/numberOfHits);
      % disp(numberOfHits);
      % if(numberOfHits == 0)
      %   disp(xpoint_line);
      %   disp(ypoint_line);

      % else
      % disp(floredx);
      if(degree == 0)
%           disp("it is here");
        backProjectedImage(floredx, floredy) =(projectionData(index, indexForProjectionData)/(imagesizeR*sqrt(2)*(numberOfHits/100)));
%         disp(numberOfHits);
      else
        % temp = degree;
          % disp("lala");
          % disp(floredx);
          % disp("kaka");
          % disp(floredy);
          % disp("data");
          % disp((projectionData(index, indexForProjectionData)/numberOfHits));
          % disp(floredy);
          backProjectedImage(floredx, floredy) = backProjectedImage(floredx, floredy)+ projectionData(index, indexForProjectionData)/(numberOfHits*(imagesizeR*sqrt(2)*numberOfHits/100));
        % end
      end

    end
    % pdata = data; And here
  end

  backProjectedImageRe = backProjectedImage;
%   disp(imagesizeR);
end