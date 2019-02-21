lenaNoise = imread('lena_speckle.jpg');
% lenaSmooth = median_filter(lenaNoise);
% imwrite(lenaSmooth, 'results/LenaSmooth_Median_Filter.jpg');
channel_r = lenaNoise(:,:,1);
channel_g = lenaNoise(:,:,2);
channel_b = lenaNoise(:,:,3);
lenaSmooth(:,:,1) = median_filter(channel_r);
lenaSmooth(:,:,2) = median_filter(channel_g);
lenaSmooth(:,:,3) = median_filter(channel_b);
imwrite(lenaSmooth, 'lena_speckle_Median_Filter.jpg');