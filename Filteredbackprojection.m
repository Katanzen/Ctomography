% 
%  Takes projection data as input and outputs backprojection data.
% 
function filteredBackProjectedImageRe = Filteredbackprojection(filteredbackProjectedImage, imagesizeR2, projectionData2, ~, numberOfSamplesOnRays, numberofdetectors, degree, numberOfHitArray, reference_points, originPoint, indexForProjectionData, highPassFilter)
  samplearray = linspace(-originPoint, originPoint, 100);
  halfTheImageSize2 = imagesizeR2 / 2 ;
  projectionData2 = (abs(ifft(fft(projectionData2).* highPassFilter)));
  for k = 1:numberofdetectors
    numberOfHitsToSend = numberOfHitArray(1,k);
    for i = 1:numberOfSamplesOnRays
      [xpoint2, ypoint2] = find_point_cordinates(reference_points(1, k), reference_points(2, k), samplearray(i), degree);
      calculateBackProjectionData(xpoint2, ypoint2, numberOfHitsToSend, k);
    end
  end

 

    function calculateBackProjectionData(xpoint_line2, ypoint_line2, numberOfHits2, index2)
    
    if(xpoint_line2 > -halfTheImageSize2 && xpoint_line2 < halfTheImageSize2 && ypoint_line2 > -halfTheImageSize2 && ypoint_line2 <halfTheImageSize2)

      if(xpoint_line2 < 0)
        floredx2 = halfTheImageSize2 - floor(xpoint_line2);
      else
        floredx2 = halfTheImageSize2 - floor(xpoint_line2);
      end

      if(ypoint_line2 < 0)
        floredy2 = halfTheImageSize2 + ceil(ypoint_line2);
      else 
        floredy2 = halfTheImageSize2 + ceil(ypoint_line2);        
      end

      if(degree == 0)

        filteredbackProjectedImage(floredx2, floredy2) =(projectionData2(index2, indexForProjectionData)/(imagesizeR2*sqrt(2)*(numberOfHits2/100)));

      else

          filteredbackProjectedImage(floredx2, floredy2) = filteredbackProjectedImage(floredx2, floredy2)+ projectionData2(index2, indexForProjectionData)/((imagesizeR2*sqrt(2)*numberOfHits2/100));
      end

    end
      filteredBackProjectedImageRe = filteredbackProjectedImage;
    end

end