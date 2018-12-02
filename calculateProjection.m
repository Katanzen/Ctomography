function [outputMatrix, numberOfHitArray] = myFun(image, reference_points, degree, samples, numberofdetectors, linelength, originPoint, numberOfSamples)
%myFun - Description
%
% Syntax: output = myFun(input)
%
% Long description

  imagesize = originPoint/sqrt(2);
  outputMatrix = zeros(numberofdetectors, 1);
  samplejump = linelength / samples;
  samplearray = linspace(-originPoint, originPoint, 100);
  numberofhits = 0;
  numberOfHitArray = zeros(1 , numberofdetectors);
  halfTheImageSize = imagesize;

  data = 0;

  for k = 1:numberofdetectors
    for i = 1:samples
      [xpoint, ypoint] = find_point_cordinates(reference_points(1, k), reference_points(2, k), samplearray(i), degree);
       attenuation = calculateProjectionData(xpoint, ypoint);
    end
    % disp(degree);
    % disp(numberofhits);
    numberOfHitArray(1,k) = numberofhits;
    %  NUMBER OF HİTS
    % if(numberofhits ~= 0)
    %   attenuation = attenuation / numberofhits;
    % else
    %   attenuation = 0;
    % end
    numberofhits = 0;

    outputMatrix(k, 1) = attenuation;
    data = 0;
    % disp(degree);

  end
  % disp(numberOfHitArray);
  % plot(outputMatrix);

  function pdata = calculateProjectionData(xpoint_line, ypoint_line)
    if(xpoint_line > -imagesize && xpoint_line < imagesize && ypoint_line > -imagesize && ypoint_line <imagesize)
      % NUMBER OF HİTS AGAİN
      numberofhits = numberofhits + 1;
      % if(xpoint_line < 0)
      %   floredx = 2 + ceil(xpoint_line);
      % else
      %   floredx = 2 + floor(xpoint_line);
      % end

      % if(ypoint_line < 0)
      %   floredy = 2 + ceil(ypoint_line);
      % else 
      %   floredy = 2 + floor(ypoint_line);        
      % end
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
      % disp(halfTheImageSize);
      % disp(xpoint_line);
      % disp(ypoint_line);

      % disp(floredy);
      % disp(floredx);
      data = data + image(floredx, floredy);

    else
      data = data + 0;
    end
    pdata = data;
  end




end