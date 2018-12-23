% 
%  Takes projection data as input and outputs backprojection data.
% 
function backProjectedImageRe = Backprojection(backProjectedImage, imagesizeR, projectionData, ~, numberOfSamplesOnRays, numberofdetectors, degree, numberOfHitArray, reference_points, originPoint, indexForProjectionData, lowPassFilter)
  samplearray = linspace(-originPoint, originPoint, 100);
  halfTheImageSize = imagesizeR / 2 ;
    temp_data1 = ones(1,numberofdetectors);
%   disp(highPassFilter);
  for i=1:numberofdetectors
      temp_data1(1,i) = projectionData(i,indexForProjectionData);
  end
  temp_data1 = (real(ifft((fft(temp_data1)).* lowPassFilter)));
   for i=1:numberofdetectors
      projectionData(i,indexForProjectionData) = temp_data1(1,i);
  end
  for k = 1:numberofdetectors
    numberOfHitsToSend = numberOfHitArray(1,k);
%     if(degree==45)
%         disp(numberOfHitsToSend);
%     end
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