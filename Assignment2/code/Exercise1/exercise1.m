load ('data1.mat')
k = 4;
my_data = Data(2:3,:)';
[idx,C] = kmeans(my_data,k);
e_step_matrix(300,4) = 0;
my_mean = {};
covariance = {};
for i = 1:k
temp= find(idx == i);
[m n] = size(temp);
array = my_data(temp,:);
my_mean{i} = mean(array);
covariance{i} = cov(array);
distribution{i} = mvnpdf(my_data(temp,:),my_mean{i},covariance{i});
end

for ks = 1:4
    index = find(idx==ks);
    prior(ks) = length(index)/300;
end
 



current_likelihood = 1;
plhood = 0;
%final_conv_value = 10^-3;
count = 0;
final_conv_value = 10^-3;
%while(plhood<lhood2_new)
while(current_likelihood > plhood && current_likelihood - plhood > final_conv_value)

for j= 1:300
    for k=1:4
          %e_step_matrix(j,k)
   numerator = prior(k)*mvnpdf_version(my_data(j,:)',my_mean{k}',covariance{k});
   for s = 1:4
       denominator(s) = prior(s) * mvnpdf(my_data(j,:),my_mean{s},covariance{s});
   end
   denominator_final = sum(denominator);
   e_step_matrix(j,k) = numerator/denominator_final;
    
    end
end

%m step

     for k = 1:4
        num2=0;
        num4 = 0;
    for i = 1:300
   
   % n_k(k) = sum(e_step_matrix(:,k));
    num1 =  (e_step_matrix(i,k)*my_data(i,:));
    num2=num2+num1;
    num3_covariance = (e_step_matrix(i,k) * (my_data(i,:) -my_mean{k}  )' *  (my_data(i,:) -my_mean{k})   );
    num4 = num4+num3_covariance;
    end
    final_num{k}= num2;
    final_cov{k} = num4;
    n_k(k) = sum(e_step_matrix(:,k));
    new_mean{k} = final_num{k}/n_k(k);
    new_covariance{k} = final_cov{k}/n_k(k); 
     new_prior(k) = sum(e_step_matrix(:,k) );
     
     end
     denominator_for_new_prior = sum(new_prior);
     for k = 1:4
     new_prior1(k) = new_prior(k)/denominator_for_new_prior; 
     end
    
   my_mean = new_mean;
   covariance = new_covariance;
   prior = new_prior1;
   
   % likelihood
  lhood = 0;
   lhood2 = 0;
   for i=1:300
   
       for k=1:4
   my_lhood = prior(k)*mvnpdf_version(my_data(i,:)',my_mean{k}',covariance{k});
   lhood = lhood+my_lhood;
       end
   lhood2 =lhood2+lhood;
   end
   plhood = current_likelihood;
   current_likelihood = lhood2;
   count = count+1;
end