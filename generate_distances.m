% for each letter file
clear;
clc;
cd ~/Documents/MATH149/matlab_examples; % move to location of load_javaplex.m
load_javaplex;  
cd ~/Documents/MATH149/git;             % back to project home 

filenames = [];
num_letters = [];
for ch = 'A':'Z'
    files = dir(fullfile('~','Documents', 'MATH149', 'git', 'Letters', ch, '*.jpg'));
    for f = 1:size(files,1)
        filenames = [filenames; fullfile('~','Documents', 'MATH149', 'git', 'Letters', ch, files(f).name), ' '];
    end
    num_letters = [num_letters, size(files,1)];
end
for ch = 'a':'z'
    files = dir(fullfile('~','Documents', 'MATH149', 'git', 'Letters', strcat(ch,'_'), '*.jpg'));
    for f = 1:size(files,1)
        filenames = [filenames; fullfile('~','Documents', 'MATH149', 'git', 'Letters', strcat(ch,'_'), files(f).name)];
    end
    num_letters = [num_letters, size(files,1)];
end

codes = javaArray('edu.stanford.math.plex4.homology.barcodes.AnnotatedBarcodeCollection', sum(num_letters), 5);
pers = edu.stanford.math.plex4.api.Plex4.getModularSimplicialAlgorithm(2, 2);

max_dimension = 2;
nu = 1;
num_divisions = 100;


for s = 1:sum(num_letters)
    pc1 = get_pointcloud(strtrim(filenames(s,:)));
    pc2 = rotate90(pc1);
    pc3 = rotate90(pc2);
    pc4 = rotate90(pc3);
%     landmark_selector = api.Plex4.createMaxMinSelector(pc1, int32(size(pc1,1)/5));
%     R = landmark_selector.getMaxDistanceFromPointsToLandmarks();
%     max_filtration = 2 * R;
%     stream5 = streams.impl.LazyWinessStream(landmark_selector.getUnderlyingMetricSpace(), landmark_selector, max_dimension, max_filtration, nu, num_divisions);
    map1 = get_vertex_points_map(pc1);
    map2 = get_vertex_points_map(pc2);
    map3 = get_vertex_points_map(pc3);
    map4 = get_vertex_points_map(pc4);
    kmap1 = get_vertex_points_map(pc1);
    stream1 = connect_vertices(map1);
    stream2 = connect_vertices(map2);
    stream3 = connect_vertices(map3);
    stream4 = connect_vertices(map4);
    codes(s, 1) = pers.computeAnnotatedIntervals(stream1);
    codes(s, 2) = pers.computeAnnotatedIntervals(stream2);
    codes(s, 3) = pers.computeAnnotatedIntervals(stream3);
    codes(s, 4) = pers.computeAnnotatedIntervals(stream4);
    %codes(s, 5) = pers.computeAnnotatedIntervals(stream5);
end
    


distances = zeros(sum(num_letters));
for row = 1:sum(num_letters)
    for col = row:sum(num_letters)
        distances(row, col) = distance(codes(row,1:4), codes(col,1:4));
    end
end
distances = distances + distances';
dlmwrite('distances', distances)
