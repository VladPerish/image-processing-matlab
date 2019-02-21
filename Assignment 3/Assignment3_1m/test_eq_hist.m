I = imread('AtlasMercury.tif');
[h, lut, eq_I] = HistogramEqualization(I);
eq_h = compute_hist(eq_I);
figure;
image(I);
title('origin image');
figure;
image(eq_I);
title('hist equalization image');
imwrite(eq_I, 'Hist_eqed.png');

x = 0 : 255;
h1_img = figure;
bar(x, h(:, 1));
title('origin histogram');
saveas(h1_img, 'original_hist.png');
h2_img = figure;
bar(x, eq_h(:, 1));
title('equalized histogram');
saveas(h2_img, 'eqed_hist.png');

