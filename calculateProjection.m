function outputMatrix = myFun(image, reference_points, degree, samples, numberofdetectors, linelength, originPoint)
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


  data = 0;

  for k = 1:numberofdetectors
    for i = 1:samples
      [xpoint, ypoint] = find_point_cordinates(reference_points(1, k), reference_points(2, k), samplearray(i), degree);
       attenuation = calculateProjectionData(xpoint, ypoint);
    end
    if(numberofhits ~= 0)
      attenuation = attenuation / numberofhits;
    else
      attenuation = 0;
    end
    outputMatrix(k, 1) = attenuation;
    data = 0;
    numberofhits = 0;
    disp(degree);

  end
  % plot(outputMatrix);

  function [x, y] = find_point_cordinates(constX, constY, distance, degree)
    if(degree == 0)
      x = constX;
      y = constY + distance;
    end
    if(degree>0)
      if(distance < 0)
        x = (constX - distance*sind(degree));
        y = (constY - distance*cosd(degree));
      else
        x = (constX + distance*sind(degree));
        y = (constY + distance*cosd(degree));
      end        
      
    end
  end 

  
  


  function pdata = calculateProjectionData(xpoint_line, ypoint_line)
    if(xpoint_line > -imagesize && xpoint_line < imagesize && ypoint_line > -imagesize && ypoint_line <imagesize)
      numberofhits = numberofhits + 1;
      if(xpoint_line < 0)
        floredx = 2 + ceil(xpoint_line);
      else
        floredx = 2 + floor(xpoint_line);
      end

      if(ypoint_line < 0)
        floredy = 2 + ceil(ypoint_line);
      else 
        floredy = 2 + floor(ypoint_line);        
      end
      % disp(floredy);
      data = data + image(floredx, floredy);

    else
      data = data + 0;
    end
    pdata = data;
  end




end