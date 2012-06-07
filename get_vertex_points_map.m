function [ vertex_points_map ] = get_vertex_points_map( pc )
%GET_VERTEX_POINTS_MAP Generates a map from vertex numbers to constituent
%points
%   Detailed explanation goes here
   vertex_points_map = containers.Map('KeyType', 'int32', 'ValueType', 'any');

curr_point = [-1 -1];
curr_vertex_num = -1;
for i = 1:size(pc, 1)
  if pc(i, 2) ~= curr_point(1, 2) || pc(i, 1) > 1 + curr_point(1, 1);
    % we are starting a new vertex
    curr_vertex_num = curr_vertex_num + 1;
    vertex_points_map(curr_vertex_num) = [pc(i, 1) pc(i, 2)];
  else
    % we are adding a point to the same vertex
    vertex_points_map(curr_vertex_num) = [vertex_points_map(curr_vertex_num); [pc(i, 1) pc(i, 2)]];
  end
  curr_point = [pc(i, 1) pc(i, 2)];
end

end

