% I = imread('Board.bmp');
% imshow(I);
% axis off;
% title('Original Image');
% thresh = multithresh(I,2);
% seg_I = imquantize(I,thresh);
% RGB = label2rgb(seg_I); 	 
% figure;
% imshow(RGB);
% axis off;
% title('RGB Segmented Image');

clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.
format longg;
format compact;
fontSize = 15;


% Read in a standard MATLAB gray scale demo image.

grayImage = imread('Board.bmp');
% Get the dimensions of the image.  
% numberOfColorBands should be = 1.
[rows columns numberOfColorBands] = size(grayImage);
% Display the original gray scale image.
subplot(2, 2, 1);
imshow(grayImage, []);
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Give a name to the title bar.
set(gcf,'name','Demo by ImageAnalyst','numbertitle','off') 

% Let's compute and display the histogram.
[pixelCount grayLevels] = imhist(grayImage);
subplot(2, 2, 2); 
bar(pixelCount);
grid on;
title('Histogram of original image', 'FontSize', fontSize);
xlim([0 grayLevels(end)]); % Scale x axis manually.

% Quantize
prompt = 'Quantization bit? = ';
newbit = input(prompt);
newMax = 2^newbit - 1;
sizeOfGrayLevels = size(grayLevels);
numberOfGrayLevels = sizeOfGrayLevels(1,1);
quantizedImage = uint8(mat2gray(grayImage) * (newMax));
% Display the original gray scale image.
subplot(2, 2, 3);
imshow(quantizedImage, []);
caption = sprintf('Image quantized into %d bits or %d gray levels ', newbit ,newMax);
title(caption, 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Give a name to the title bar.
set(gcf,'name','Demo by ImageAnalyst','numbertitle','off') 

% Let's compute and display the histogram.
[pixelCount grayLevels] = imhist(quantizedImage);
subplot(2, 2, 4); 
bar(pixelCount);
grid on;
caption = sprintf('Histogram of image quantized into %d bits or %d gray levels ', newbit ,newMax);
title(caption, 'FontSize', fontSize);
lastGL = find(pixelCount>0, 1, 'last');
xlim([0 lastGL+1]); % Scale x axis manually.
