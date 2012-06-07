function [ pc ] = get_pointcloud( image_file )
%GET_POINTCLOUD Create a pointcloud from a bmp file
%   Take the bitmap, divide it by 255, invert, add a new point in the point
%   cloud for each of the black pixels

im = 1 - (imread(image_file) / 255);
pc = zeros(sum(sum(im(:,:,1))), 2);
count = 1;
for x = 1:size(im,1)
    for y = 1:size(im,2)
        if im(x,y) >= 1
            pc(count,:) = [y x];
            count = count + 1;
        end
    end
end
end

