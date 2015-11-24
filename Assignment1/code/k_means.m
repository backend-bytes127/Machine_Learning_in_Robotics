function [next_iteration_centroids,total_distortion,clusters] = k_means(number_of_clusters,mydata,current_centroids)

rows = size(mydata,1);
columns = size(mydata,2);
mydata_dimension = [];
vector = [];
for i = 1:rows
    for j = 1:columns
        for k = 1:number_of_clusters
            mydata_dimension = [mydata(i,j,1), mydata(i,j,2), mydata(i,j,3)];
            distortion_measure = (mydata_dimension - current_centroids(k,:)).^2;
            distortion_to_find_minimum(i,j,k) = sum(distortion_measure) ;
            vector = [vector;distortion_to_find_minimum(i,j,k)];
        end
        [m_distortion i_distortion] = min(vector);
        cluster_matrix_index(i,j) = i_distortion;
        cluster_matrix_values(i,j) = m_distortion;
        vector = [];
    end
end

 for k = 1:number_of_clusters
     sum_centroid = [0;0;0];
     counter = 0;
    for i = 1:rows
        for j = 1:columns
           
                if(cluster_matrix_index(i,j) == k)
                     mydata_dimension = [mydata(i,j,1); mydata(i,j,2); mydata(i,j,3)];
                     sum_centroid = sum_centroid+mydata_dimension;
                     counter = counter + 1;
                end
            end
    end
        next_iteration_centroids(k,:) = sum_centroid/counter;
 end
    
    final_sum_distortion = 0;
    
    for i = 1:rows
        for j = 1:columns
            for z = 1: number_of_clusters
                if(cluster_matrix_index(i,j) == k)
                 mydata_dimension = [mydata(i,j,1), mydata(i,j,2), mydata(i,j,3)];
                 final_sum_distortion  = final_sum_distortion + sum( (mydata_dimension- next_iteration_centroids(k,:)).^2);
                end
            end
        end
    end
    total_distortion = final_sum_distortion;
    clusters = cluster_matrix_index;

