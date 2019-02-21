% %%For test1.jpg
% 
img1 = imread('test1.jpg');
a = 2;
x = 0:255;
LUT1 = 255 ./ (1+exp(-a*(x-200)/50));

plot(0:255, LUT1);
axis tight;
grid; 

out1 = LUT1(img1 + 1); 
out_image1 = uint8(out1);

imwrite(out_image1,'test1_out.jpg');




%%For test2.jpg

img2 = imread('test2.jpg');
a = 3;
x = 0:255;
LUT2 = 200 ./ (1+exp(-a*(x-50)/50));

plot(0:255, LUT2);
axis tight;
grid; 

out2 = LUT2(img2 + 1); 
out_image2 = uint8(out2);

imwrite(out_image2,'test2_out.jpg');

% 
% 
% 
% %%For test3.jpg
% 
img3 = imread('test3.jpg');
a = 3;
x = 0:255;
LUT3 = 192 ./ (1+exp(-a*(x-125)/75));

plot(0:255, LUT3);
axis tight;
grid; 

out3 = LUT3(img3 + 1); 
out_image3 = uint8(out3);

imwrite(out_image3,'test3_out.jpg');