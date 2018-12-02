% 
%  FİNDS THE CORDİNATES OF THE POİNTS ON X_RAY BEAMS
% 
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