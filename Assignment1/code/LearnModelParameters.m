function [mu,Sigma] = LearnModelParameters(images, num_images)



imStart = 'George_W_Bush_';
imExt = '.jpg';

%num_images = 530;
rgbValues1 = [];

for i =1:num_images
    iStr = sprintf('%04d', i); % we need 3 zeros padded...
    imName = strcat(images, imStart, iStr, imExt);
    rgbValues = ExtractCenterPixels(imName, 0.2);
    %imtool(rgbValues);
    %
   %pause
  
    rgbValues1 = [rgbValues1;rgbValues];
end

%imtool(rgbValues1)
%centerpixels = ExtractCenterPixels(ImageName, p)

mean1 = mean(double(rgbValues1));
mu = mean1';
covariance = cov(double(rgbValues1));
Sigma = covariance';















end