function [distance] = distance(code1, code2)
%DISTANCE
%
distance = 0;
for i = 1:4
    distance = distance + bottleneck_distance(code1(i), code2(i)) ^ (-1);
end
distance = (distance / 4 )^ (-1);
end