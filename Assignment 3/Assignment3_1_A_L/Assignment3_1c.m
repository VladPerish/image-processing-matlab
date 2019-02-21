% img = imread('AtlasMercury.tif'); 
% 
% 
% Val_hist = (1/3)*(MyHistogram(img(:,1))+MyHistogram(img(:,2))+MyHistogram((img(:,3))));
% 
% grayLevels = 0 : 255;
% bar(grayLevels, Val_hist(:,1), 'BarWidth', 1, 'FaceColor', 'b');
% xlabel('Gray Level', 'FontSize', 20);
% ylabel('Pixel Count', 'FontSize', 20);
% title('Histogram', 'FontSize', 20);
% grid on;
% 
% 
% function [counts, grayLevels] = MyHistogram(inputImage);
% [rows, columns, numberOfColorChannels] = size(inputImage);
% counts = zeros(1, 256);
% for col = 1 : columns
% 	for row = 1 : rows
% 		% Get the gray level.
% 		grayLevel = inputImage(row, col);
% 		% Add 1 because graylevel zero goes into index 1 and so on.
% 		counts(grayLevel) = counts(grayLevel) + 1;
% 	end
% end
% end
% 
% 
% 


I = imread('Dec_bright.png');
h_I = compute_hist(I);
x = 0 : 255;
figure;
image(I);
title('original image');
figure;
bar(x, h_I(:, 1));
title('original image histogram');


function h = compute_hist( img )
%compute histogram of an image

[m, n, c] = size(img);
h = zeros([256, c]);
for i = 1 : 256
    h(i, :) = sum(sum(img == (i - 1)));
end
end