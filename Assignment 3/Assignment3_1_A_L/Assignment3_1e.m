img = imread('AtlasMercury.tif');
img = im2double(img);
figure;
imshow(img);
title('Original Image');


IncreasedBrightnessImg = img + .3;

figure;
imshow(IncreasedBrightnessImg);
imwrite(IncreasedBrightnessImg,'Inc_bright.png');
title('Increased Brightness');
