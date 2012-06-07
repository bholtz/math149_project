function [ d ] = bottleneck_distance( ai1, ai2 )
%BOTTLENECK_DISTANCE Compute the Bottleneck distance between two streams
%   Detailed explanation goes here
    i10 = ai1.getIntervalsAtDimension(0);
    i11 = ai1.getIntervalsAtDimension(1);
    i20 = ai2.getIntervalsAtDimension(0);
    i21 = ai2.getIntervalsAtDimension(1);
    d0 = edu.stanford.math.plex4.bottleneck.BottleneckDistance.computeBottleneckDistance(i10, i20);
    if size(i11) == 0 || size(i21) == 0
        d1 = 0;
    else
        d1 = edu.stanford.math.plex4.bottleneck.BottleneckDistance.computeBottleneckDistance(i11, i21);
    end
    d = sqrt(d0 * d0 + d1 * d1);
end

