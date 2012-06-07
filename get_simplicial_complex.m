funtion sc = get_simplicial_complex( point_cloud )
% get_simplicial_complex takes the point cloud generated
% by get_pointcloud and converts it to an abstract s.c.

% the connected components of points in each row are identified
% as vertices, and two vertices in different rows, v_1 and v_2,
% are connected iff there exists a pair of points p_1, p_2
% with p_1 \in v_1, p_2 \in v_2, and d(p_1, p_2) <= sqrt(2)/2

function vertex_points_map = get_vertex_points_map( point_cloud )
% returns a map, mapping each vertex number to the set of points comprising that vertex
vertex_points_map = containers.Map('KeyType', 'uint32', 'ValueType', 'any');

curr_point = [-1 -1]
curr_vertex_num = -1
for i = 1:size(point_cloud, 1)
  if pc(i, 1) ~= curr_point(1, 1) | pc(i, 2) > 1 + curr_point(1, 2)
    % we are starting a new vertex
    curr_vertex_num = curr_vertex_num + 1
    vertex_points_map(curr_vertex_num) = [pc(i, 1) pc(i, 2)]
  else
    % we are adding a point to the same vertex
    vertex_points_map(curr_vertex_num) = [vertex_points_map(curr_vertex_num); [pc(i, 1) pc(i, 2)]]
  end
end

%{
curr_row = point_cloud(1, 1);
curr_col = point_cloud(1, 1);
curr_row_start = curr_vertex_num = 0;
prev_row_start = prev_row_end -1; % the lowest and highest vertex numbers, respectively, from the previous row
vertex_points_map = containers.Map('KeyType', 'uint32', 'ValueType', 'any');

sc = api.Plex4.createExplicitSimplexStream();

for i = 1:size(pc, 1)
  if pc(i, 1) ~= curr_row % we're starting a new row
    prev_row_start = curr_row_start;
    prev_row_end = curr_vertex_num;
    curr_vertex_num = curr_vertex_num + 1;
    curr_row_start = curr_vertex_num;
    curr_row = pc(i, 1); curr_col = pc(i, 2);
  else % we're on the same row
    % check to see if our column has "jumped" by more than one
    if pc(i, 2) > curr_col + 1
      % if so, add curr_vertex_num as a vertex and increment it
      sc.addVertex(curr_vertex_num);
      curr_vertex_num = curr_vertex_num + 1;
    end
  end

  % and check if this point has any connections in the previous row
  for j = prev_row_start:prev_row_end
    j_is_neighbor = 0
    for k = 1:size(vertex_points_map(j))
      if dist([curr_row curr_col], vertex_points_map(j)[k]) < sqrt(2)
        j_is_neighbor = 1;
        break
      end
    end
    if j_is_neighbor
      sc.addEdge(curr_vertex_num, j);
    end
  end
%}
