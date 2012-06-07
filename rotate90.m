function [ pc_rot ] = rotate90( pc )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    ymid = round((max(pc(:,2)) + min(pc(:, 2))) / 2);
    xmid = round((max(pc(:,1)) + min(pc(:, 1))) / 2);
    pc_rot = [pc(:,1)-xmid, (pc(:,2)-ymid)];
    pc_rot = [pc_rot(:,2).*(-1), pc_rot(:,1)];
    pc_rot = [pc_rot(:,1)+xmid, (pc_rot(:,2) + ymid)];
    pc_rot = sortrows(sortrows(pc_rot,1),2);
end

