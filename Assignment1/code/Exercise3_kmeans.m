function Exercise3_kmeans(data,clusterlabels,k1)
%load('gesture_dataset.mat')



% datset gesture_l,gesture_o,gesture_x

%current_centroids_o = init_cluster_o;
%current_centroids_l = init_cluster_l;
%current_centroids_x = init_cluster_x; 
current_centroids_x = clusterlabels;
number_of_clusters = k1;

next_iteration_centroids = zeros(k1,3);


counter_for_iteration = 0;

while 1
	[next_iteration_centroids,total_distortion,clusters]=k_means(number_of_clusters,data,current_centroids_x);

	if isequal(current_centroids_x,next_iteration_centroids)
		break;
	end

	current_centroids_x = next_iteration_centroids;
	counter_for_iteration = counter_for_iteration+1;

	end

figure;
hold on;
color_map = ['b', 'k', 'r', 'g', 'm', 'y', 'c'];

for i = 1:60
    for j = 1:10
        for k = 1:7
            if clusters(i,j) == k
                scatter(data(i, j, 1), data(i, j, 2), [], color_map(k));
            end
        end
    end
end
hold off;

