function [ stream ] = connect_vertices( map )
%CONNECT_VERTICES Summary of this function goes here
%   Detailed explanation goes here
   
    stream = api.Plex4.createExplicitSimplexStream();
        
    min_row = get_row(map, 1);
    start_vertex = -1;
    
    % Add each vertex (conencted component) to the stream
    for i = 1:map.Count
        row = get_row(map, i);   % There must be at least one vertex, so 
        stream.addVertex(i, row) % we use it's y-value as the filtration param
        if row == min_row + 1 && start_vertex == -1
            start_vertex = i;
        end
    end
    
    % We use the min and max filtartion values to know which rows to look
    % through. Also we'll use the fact that the row number is monotonic in
    % the vertex index
    
    vertex = start_vertex;
    min_last_vertex = 1;
    max_last_vertex = 
    for i = start_vertex:map.Count
        vertex
end

