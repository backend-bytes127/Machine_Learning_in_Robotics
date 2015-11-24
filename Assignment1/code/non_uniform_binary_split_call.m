function [myclusters,distortion, centroids_for_each_iteration ] = non_uniform_binary_split_call( mydata,K )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


% step 1: find centres 

centroids = sum(sum(mydata))./(60 * 10);

centroids_for_each_iteration{1} = centroids;

for jj = 2:7
    centroids_for_each_iteration{jj} = 0.*centroids;
end

myclusters = ones(60,10);

for current_value_of_cluster = 1:K

     distortion = zeros(1,K);
     next_iteration_data_set = zeros(size(mydata));
for rows = 1:size(mydata,1)
    for columns = 1:size(mydata,2)
        for k = 1:current_value_of_cluster
            if myclusters(rows,columns) == k
                distortion(k) = distortion(k) + sum( (centroids_for_each_iteration{k} - mydata(rows,columns,:)).^2);
                
            end
        end
    end
end


[distortion_value distortion_index] = max(distortion);

for rows = 1:size(mydata,1)
    for columns = 1:size(mydata,2)
       % for k = 1:K
            if myclusters(rows,columns) == distortion_index;
                
                next_iteration_data_set(rows,columns,:) = mydata(rows,columns,:);
            end
    end
end


mean_A =  centroids_for_each_iteration{distortion_index}   + rand();
mean_B =    centroids_for_each_iteration{distortion_index} - rand();


difference_A = sum(  (bsxfun(@minus,next_iteration_data_set,mean_A).^2),3); 
difference_B = sum(  (bsxfun(@minus,next_iteration_data_set,mean_B).^2),3);

coun_for_A = 0;
coun_for_B = 0;

splitted_data = (difference_A<difference_B);

for rows = 1:60
    for columns = 1:10
        for k = 1:K
            if next_iteration_data_set(rows,columns,1) ~= 0 && next_iteration_data_set(rows,columns,2) && next_iteration_data_set(rows,columns,3)
                if splitted_data(rows,columns) == 1
                    myclusters(rows,columns) = distortion_index;
                     centroids_for_each_iteration{distortion_index} = centroids_for_each_iteration{distortion_index}+ next_iteration_data_set(rows,columns,:);
                     coun_for_A = coun_for_A+1;
                else
                    centroids_for_each_iteration{current_value_of_cluster+1} =  centroids_for_each_iteration{current_value_of_cluster+1} +  next_iteration_data_set(rows,columns,:);
                    myclusters(rows,columns) = current_value_of_cluster+1;
                    coun_for_B = coun_for_B+1;
                end
            end
        end
    end
end
 centroids_for_each_iteration{distortion_index} = centroids_for_each_iteration{distortion_index}./ coun_for_A;
   centroids_for_each_iteration{current_value_of_cluster+1} = centroids_for_each_iteration{current_value_of_cluster+1}./ coun_for_B ;
end

                    
end

