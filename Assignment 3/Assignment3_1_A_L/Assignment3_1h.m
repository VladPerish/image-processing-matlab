
rgbImage = imread('AtlasMercury.tif');
hsvImage = rgb2hsv(rgbImage);
hChannel = hsvImage(:, :, 1);
sChannel = hsvImage(:, :, 2);
vChannel = hsvImage(:, :, 3);
meanV = mean2(vChannel);
newV = meanV + .5 * (vChannel - meanV); % Decrease contrast by factor of 2
newHSVImage = cat(3, hChannel, sChannel, newV);
newRGBImage = hsv2rgb(newHSVImage);
imshow(rgbImage);
figure;
imshow(newRGBImage);
imwrite(newRGBImage,'contrast_dec.png');