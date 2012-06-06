funtion sc = get_simplicial_complex( point_cloud )
% get_simplicial_complex takes the point cloud generated
% by get_pointcloud and converts it to an abstract s.c.

% the connected components of points in each row are identified
% as vertices, and two vertices in different rows, v_1 and v_2,
% are connected iff there exists a pair of points p_1, p_2
% with p_1 \in v_1, p_2 \in v_2, and d(p_1, p_2) <= sqrt(2)/2

curr_row = point_cloud[1][1];
curr_col = point_cloud[1][2];
curr_row_start = curr_vertex_num = 0;
prev_row_start = -1; % the lowest vertex number from the previous row
sc = api.Plex4.createExplicitSimplexStream();

for i = 1:size(pc)
  if pc[i][1] ~= curr_row % we're starting a new row
    prev_row_start = curr_row_start;
    curr_vertex_num = curr_vertex_num + 1;
    curr_row_start = curr_vertex_num;
    curr_row = pc[i][1]; curr_col = pc[i][2];
  else % we're on the same row
    % check to see if our column has "jumped" by more than one
    % if so, increment curr_vertex_num
    if pc[i][2] > curr_col + 1
      
