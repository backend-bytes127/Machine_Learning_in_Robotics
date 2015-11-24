function LikValues = EvaluateLikelihood(Image, mu,sigma)

mimage=imread(Image);
[height1 width1 zz] = size(mimage);

y = [];

for i = 1:height1
    for j = 1:width1

    pixel = [mimage(i,j,1);mimage(i,j,2);mimage(i,j,3)];
y(i,j) = mvnpdf(double(pixel), mu,sigma);
    end
end



LikValues = y;
% figure(11)
% imshow(LikValues/max(max(LikValues)))

end