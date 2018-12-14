% 
%  Takes projection data as input and outputs backprojection data.
% 
function backProjectedImageRe = Backprojection(backProjectedImage, imagesizeR, projectionData, ~, numberOfSamplesOnRays, numberofdetectors, degree, numberOfHitArray, reference_points, originPoint, indexForProjectionData)
  samplearray = linspace(-originPoint, originPoint, 100);
  halfTheImageSize = imagesizeR / 2 ;
  for k = 1:numberofdetectors
    numberOfHitsToSend = numberOfHitArray(1,k);
    for i = 1:numberOfSamplesOnRays
      [xpoint, ypoint] = find_point_cordinates(reference_points(1, k), reference_points(2, k), samplearray(i), degree);
      calculateBackProjectionData(xpoint, ypoint, numberOfHitsToSend, k);
      end
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
      end

    end
      backProjectedImageRe = backProjectedImage;
    end

end