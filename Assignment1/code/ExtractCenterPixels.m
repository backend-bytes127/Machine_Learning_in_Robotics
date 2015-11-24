function CenterPixels =  ExtractCenterPixels(ImageName,p)


myimage = imread(ImageName);

[height,width,z] = size(myimage);

center_width = floor(width/2);
center_height = floor(height/2);


%construct rectangle

%start_point_w_up = center_width +  (p*width)/2
%start_point_h_up = center_height + (p*height)/2

start_point_w_down = floor(center_width -  (p*width)/2);

start_point_h_down = floor(center_height - (p*height)/2);
CenterPixels = imcrop(myimage,[start_point_h_down,start_point_w_down,floor(p*height),floor(p*width)] );


%width1 = start_point_w_up - start_point_w_down;
%height1 = start_point_h_up - start_point_h_down;


CenterPixels = reshape(CenterPixels, [size(CenterPixels,1) * size(CenterPixels,2),3]);


end