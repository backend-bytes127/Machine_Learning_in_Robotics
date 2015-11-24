function Exercise3_nubs(mydata,k1)
%load('gesture_dataset.mat')

%mydata = gesture_x;
% current_centroids = init_cluster_l;

% step 1: find centroids

cc = non_uniform_binary_split_call(mydata,k1-1);
figure;
hold on;
color_map = ['b', 'k', 'r', 'g', 'm', 'y', 'c'];
clustered_values = [];

for x = 1:size(cc, 1)
    for y = 1:size(cc, 2)
        for k = 1:7
            if cc(x, y) == k
                scatter(mydata(x, y, 1), mydata(x, y, 2), [], color_map(k));
            end
        end
    end
end
hold off;