function [ stream ] = connect_vertices( map )
%CONNECT_VERTICES Summary of this function goes here
%   Detailed explanation goes here
    stream = edu.stanford.math.plex4.streams.impl.ExplicitSimplexStream;  
    min_row = get_row(map, 0);
    start_vertex = -1;
    
    % Add each vertex (conencted component) to the stream
    for vtx = 0:map.Count-1
        row = get_row(map, vtx);   % There must be at least one vertex, so 
        stream.addVertex(int32(vtx), int32(row - min_row)) % we use it's y-value as the filtration param
        if row ~= min_row && start_vertex == -1
            start_vertex = vtx;  % at which vertex do we begin to add edges 
        end
    end
    
    
    last_row_min = 0;                 % keep track of mindex of last row
    last_row_max = start_vertex - 1;  % as well as maxdex
    cur_row = get_row(map, start_vertex);
    for vtx = start_vertex:map.Count-1
        row = get_row(map, vtx);
        if row ~= cur_row   % when we move to the next row
            cur_row = row;  % update all row variables
            last_row_min = last_row_max + 1;
            last_row_max = vtx -1;
        end
        for old = last_row_min:last_row_max
            if vertices_are_close(map(old), map(vtx))
                stream.addElement([int32(old), int32(vtx)], int32(row - min_row));
            end
        end
    end
    stream.finalizeStream();
end

