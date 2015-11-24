function Exercise2(Image)

dir = pwd();
images = strcat(dir,'/lfw-bush/lfw/George_W_Bush/');
[mu sigma] = LearnModelParameters(images,20);

%images_test = 
final_plot = imread(Image);
Values = EvaluateLikelihood(Image, mu,sigma);
%final_plot = imread('SampleImage2.jpg')
%Values  = EvaluateLikelihood('SampleImage2.jpg', mu,sigma);
%final_plot = imread('SampleImage.jpg')
%Values  = EvaluateLikelihood('SampleImage.jpg', mu,sigma);
figure(11);
imshow(Values/max(max(Values)));

Values1 = background(Image);
figure(12)
imshow(Values1/max(max(Values1)));

Values2 = Values./Values1;

[height width] = size(Values2);

for i = 1:(height)
    for j = 1:(width)
   
        if (Values2(i,j) >=1)
            Values2(i,j) = 1;
        else
            Values2(i,j) = 0;
    end
end
end

[X,Y] =FindBiggestComp(Values2);
startX = X(1);
startY = Y(1);
width = abs(X(1)- X(3));
height =  abs(Y(1) - Y(2));
figure(1)
imshow(final_plot);


hold on
rectangle('Position',[startX,startY,width,height]', 'EdgeColor','r');




 condition = (Values2 >=1);
 all_ones = Values2(condition);
% 
 condition_zeros = (Values2<1);
 all_zeros = Values2(condition_zeros);


all_zeros = Values(condition);
figure(2);
imshow(Values2);



