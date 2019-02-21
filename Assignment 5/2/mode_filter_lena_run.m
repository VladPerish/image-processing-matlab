lenaNoise = imread('c_speckle.jpg');
channel_r = lenaNoise(:,:,1);
channel_g = lenaNoise(:,:,2);
channel_b = lenaNoise(:,:,3);
lenaSmooth(:,:,1) = mode_filter(channel_r);
lenaSmooth(:,:,2) = mode_filter(channel_g);
lenaSmooth(:,:,3) = mode_filter(channel_b);
imwrite(lenaSmooth, 'c_speckle_Mode_Filter.jpg');