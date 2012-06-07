function [ row ] = get_row( map, vertex )
%GET_ROW Summary of this function goes here
%   Detailed explanation goes here
    points = map(vertex);
    row = points(1,2);

end

