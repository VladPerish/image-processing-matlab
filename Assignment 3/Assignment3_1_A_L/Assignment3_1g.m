
rgbImage = imread('AtlasMercury.tif');
hsvImage = rgb2hsv(rgbImage);
hChannel = hsvImage(:, :, 1);
sChannel = hsvImage(:, :, 2);
vChannel = hsvImage(:, :, 3);
meanV = mean2(vChannel);
newV = meanV + 2 * (vChannel - meanV); % Increase contrast by factor of 2
newHSVImage = cat(3, hChannel, sChannel, newV);
newRGBImage = hsv2rgb(newHSVImage);
imshow(rgbImage);
figure;
imshow(newRGBImage);
imwrite(newRGBImage,'contrast_inc.png');