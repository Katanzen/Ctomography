% 
%  Takes projection data as input and outputs backprojection data.
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
    floredxC = -10;
    floredyC = -10;
    xCounter = 0;
    yCounter = 0;
    for i = 1:numberOfSamplesOnRays
      [xpoint, ypoint] = find_point_cordinates(reference_points(1, k), reference_points(2, k), samplearray(i), degree);
      calculateBackProjectionData(xpoint, ypoint, numberOfHitsToSend, k);
%       if(xpoint > -halfTheImageSize && xpoint< halfTheImageSize && ypoint > -halfTheImageSize && ypoint <halfTheImageSize)
%           if(floredxC == floredx)
%               xCounter = xCounter + 1;
%           else
%               disp(xCounter);
%               backProjectedImage(floredx, floredy) = backProjectedImage(floredx, floredy) / xCounter+1; 
%               floredxC = floredx;
%               xCounter = 1;
%               yCounter = 1;
%           end
%           if(floredyC == floredy)
%               yCounter = yCounter + 1;
%           else
%               disp(yCounter);
%               backProjectedImage(floredx, floredy) = backProjectedImage(floredx, floredy) / xCounter+1;
%               floredyC = floredy;
%               yCounter = 1;
%               xCounter = 1;
%           end
         
      end
%       if(k==4 && degree==45)
%         disp("++++++++++++++++");
%         disp(xpoint);
%         disp("++++++++++++++++");
%         disp(ypoint);
%         disp("++++++++++++++++");
%         disp(xCounter);
%         disp(yCounter);
%       end
      
    end

 

    function calculateBackProjectionData(xpoint_line, ypoint_line, numberOfHits, index)
    
    if(xpoint_line > -halfTheImageSize && xpoint_line < halfTheImageSize && ypoint_line > -halfTheImageSize && ypoint_line <halfTheImageSize)

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

      if(degree == 0)

        backProjectedImage(floredx, floredy) =(projectionData(index, indexForProjectionData)/(imagesizeR*sqrt(2)*(numberOfHits/100)));

      else

          backProjectedImage(floredx, floredy) = backProjectedImage(floredx, floredy)+ projectionData(index, indexForProjectionData)/((imagesizeR*sqrt(2)*numberOfHits/100));
        % end
      end

    end
    % pdata = data; And here
      backProjectedImageRe = backProjectedImage;
    end

end
%   disp(imagesizeR);