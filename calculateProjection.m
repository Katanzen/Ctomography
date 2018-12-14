function [outputMatrix, numberOfHitArray] = myFun(image, reference_points, degree, samples, numberofdetectors, linelength, originPoint, numberOfSamples)
%myFun - Description
%
% Syntax: output = myFun(input)
%
% Long description
%    disp(originPoint);
  imagesize = originPoint/sqrt(2);
  outputMatrix = zeros(numberofdetectors, 1);
  samplejump = linelength / samples;
  samplearray = linspace(-originPoint, originPoint, 100);
  numberofhits = 0;
  numberOfHitArray = zeros(1 , numberofdetectors);
  halfTheImageSize = imagesize;
  data = 0;
  doksanderece=zeros(1,100);
  doksan1derece=zeros(2,100);
  for k = 1:numberofdetectors
    for i = 1:samples
      [xpoint, ypoint] = find_point_cordinates(reference_points(1, k), reference_points(2, k), samplearray(i), degree);
       attenuation = calculateProjectionData(xpoint, ypoint);
       if(degree==90 && k==5)
%            disp(samplearray(i));
%            disp(xpoint);
%            disp(ypoint);
%            disp(attenuation);
       end
       
    end
%     disp(attenuation);
    if(degree==1 && k==6)
%         disp("laal");
%         disp(numberofhits);
%         disp(reference_points(:,k));
%         disp(attenuation);
%         disp(xpoint);
%         disp(ypoint);
    end
    numberOfHitArray(1,k) = numberofhits;

    %  NUMBER OF HITS
    if(numberofhits ~= 0)
      attenuation = (attenuation / numberofhits)*(imagesize*2*sqrt(2)* (numberofhits/100));
    else
      attenuation = 0;
    end
    numberofhits = 0;

    outputMatrix(k, 1) = attenuation;
    data = 0;
    % disp(degree);

  end

  function pdata = calculateProjectionData(xpoint_line, ypoint_line)
    
    if(xpoint_line > -imagesize && xpoint_line < imagesize && ypoint_line > -imagesize && ypoint_line <imagesize)

      numberofhits = numberofhits + 1;
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
      data = data + image(floredx, floredy);

    else
      data = data + 0;
    end
    pdata = data;
  end
end