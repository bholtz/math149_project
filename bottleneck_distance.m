function [ d ] = bottleneck_distance( stream1, stream2 )
%BOTTLENECK_DISTANCE Compute the Bottleneck distance between two streams
%   Detailed explanation goes here
    persistence = edu.stanford.math.plex4.api.Plex4.getModularSimplicialAlgorithm(2, 2);
    ai1 = persistence.computeAnnotatedIntervals(stream1);
    ai2 = persistence.computeAnnotatedIntervals(stream2);
    i10 = ai1.getIntervalsAtDimension(0);
    i11 = ai1.getIntervalsAtDimension(1);
    i20 = ai2.getIntervalsAtDimension(0);
    i21 = ai2.getIntervalsAtDimension(1);
    d0 = edu.stanford.math.plex4.bottleneck.BottleneckDistance.computeBottleneckDistance(i10, i20);
    d1 = edu.stanford.math.plex4.bottleneck.BottleneckDistance.computeBottleneckDistance(i11, i21);
    d = sqrt(d0 * d0 + d1 * d1);
end

