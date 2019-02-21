I = imread('AtlasMercury.tif');
h_I = compute_hist(I);
target = imread('target.jpg');
h_target = compute_hist(target);
K = HistogramMatching(I, target);
h_K = compute_hist(K);

x = 0 : 255;
figure;
image(I);
title('origin image');

h1_img = figure;
bar(x, h_I(:, 1));
title('origin image histogram');
saveas(h1_img, 'original_hist.png');

figure;
image(target);
title('target image');

h2_img =figure;
bar(x, h_target(:, 1));
title('target image histogram');
saveas(h2_img, 'target_hist.png');

figure;
image(K);
title('transform image');
imwrite(K, 'Transformed_img.png');

h3_img =figure;
bar(x, h_K(:, 1));
title('transform image histogram');
saveas(h3_img, 'transformed_hist.png');
