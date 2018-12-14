% 
%  Finds The Cordinates of the points on x-ray lines.
% 
function [x, y] = find_point_cordinates(constX, constY, distance, degree)
  if(degree == 0)
    x = constX;
    y = constY + distance;
  end
  if(degree == 90)
    y = constY;
    x = constX + distance;
  end
  if((degree<90) && (degree>0))
    if(distance < 0)
      x = (constX + distance*sind(degree));
      y = (constY + distance*cosd(degree));
    end
    if(distance >0)
      x = (constX + distance*sind(degree));
      y = (constY + distance*cosd(degree));
    end 
  end
  if(degree > 90)
 
    if(distance<0)
      x = (constX + distance*sind(180-degree));
      y = (constY - distance*cosd(180-degree));       
    end
    if(distance>0)
      x = (constX + distance*sind(180-degree));
      y = (constY - distance*cosd(180-degree));
    end
  end

end 