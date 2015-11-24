function [Values1] = background(Image)
dir1 = pwd();
images = strcat(dir1,filesep,'BackgroundImages',filesep); % for linux
%images = strcat(dir,'/lfw-bush/lfw/George_W_Bush/')


[mub sigmab] = LearnModelParameters1(images,22);

%images_test = 
Values1 = EvaluateLikelihood(Image,mub,sigmab);
%Values1 = EvaluateLikelihood('SampleImage2.jpg', mub,sigmab)
% figure(3)
% imshow(Values1/max(max(Values1)))