function [ positionscale] =T368_simul_get_position(squ_length,center) 
x1 = center(1) - squ_length;
y1 = center(2) - squ_length;
x2 = center(1) + squ_length;
y2 = center(2) + squ_length;
positionscale = [x1,y1,x2,y2]';
end