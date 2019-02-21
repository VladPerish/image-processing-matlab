I = imread('AtlasMercury.tif');
h_I = compute_hist(I);
x = 0 : 255;
figure;
image(I);
title('origin image');
h = figure;
h_Val = (1/3)*(h_I(:, 1)+h_I(:, 2)+h_I(:, 3));
bar(x, h_Val(:, 1));
title('RGB image value histogram');
saveas(h,'hist_val.png')
k = figure;
h_Lum = (0.299*h_I(:, 1)+ 0.587*h_I(:, 2)+ 0.114*h_I(:, 3));
bar(x, h_Lum(:, 1));
title('RGB image Luminance histogram');
saveas(k,'hist_lum.png')



function h = compute_hist( img )
%compute histogram of an image

[m, n, c] = size(img);
h = zeros([256, c]);
for i = 1 : 256
    h(i, :) = sum(sum(img == (i - 1)));
end
end