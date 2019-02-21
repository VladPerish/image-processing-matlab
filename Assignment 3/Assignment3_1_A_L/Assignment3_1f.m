img = imread('AtlasMercury.tif');
img = im2double(img);
figure;
imshow(img);
title('Original Image');


DecreasedBrightnessImg = img - .1;
imwrite(DecreasedBrightnessImg,'Dec_bright.png');
figure;
imshow(DecreasedBrightnessImg);
title('Decreased Brightness');
