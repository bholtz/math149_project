function [ are_close ] = vertices_are_close(old, i)
%VERTICES_ARE_CLOSE Summary of this function goes here
%   Detailed explanation goes here
    old_max = old(size(old,1),1);
    i_max = i(size(i,1),1);
    old_min = old(1,1);
    i_min = i(1,1);
    are_close = ~(old_max - i_min < -1 || i_max - old_min < -1); 
end

