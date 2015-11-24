function [mu,Sigma] = LearnModelParameters1(images, num_images)


imgType = '*.jpg';

rgbValues1 = [];
for i =1:num_images
    imageFiles = dir([images imgType] );
     imName = strcat(images,imageFiles(i).name);
     rgbValues = ExtractCenterPixels(imName, 1);
%     imtool(rgbValues);
    %
  % pause
  
    rgbValues1 = [rgbValues1;rgbValues];
end


%centerpixels = ExtractCenterPixels(ImageName, p)

mean1 = mean(double(rgbValues1));
mu = mean1';
covariance = cov(double(rgbValues1));
Sigma = covariance';















end