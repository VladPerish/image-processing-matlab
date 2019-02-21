%Monochromic image display for color images for color uses frequency analysis in paintings.

inputImage = imread('AtlasMercury.tif');
imshow(inputImage);

inputImage_r = inputImage(:,:,1);
inputImage_g = inputImage(:,:,2);
inputImage_b = inputImage(:,:,3);

figure;
imshow(inputImage_r);
imwrite(inputImage_r, 'band_r.jpg');
figure;
imshow(inputImage_g);
imwrite(inputImage_g, 'band_g.jpg');
figure;
imshow(inputImage_b);
imwrite(inputImage_b, 'band_b.jpg');



