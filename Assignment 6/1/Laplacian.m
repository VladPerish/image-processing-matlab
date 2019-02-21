% clc 
% clear all 
% close all 
% image=imread('lena.png');
% filter=[0 -1 0 ; -1 9 -1 ; 0 -1 0];
% rows = size(image,1);
% cols = size(image,2);
% channel = size(image,3);
% outputimage = zeros(rows,cols,channel);
% 
% for row = 2:rows-1
%     for col = 2:cols-1
%         for i=1:3
%         outputimage (row,col,i)= sum (sum(double(image(row-1: row+1, col-1: col+1 , i)) .* filter )); 
%         end
%     end
% end 
% image =uint8(image);
% figure,imshow (outputimage);
% imwrite(outputimage, 'lena_Laplacian.png')

clc 
clear all 
close all 
image=imread('Board.bmp');
filter=[0 -1 0 ; -1 9 -1 ; 0 -1 0];
rows = size(image,1);
cols = size(image,2);
outputimage = zeros(rows,cols);

for row = 2:rows-1
    for col = 2:cols-1
         outputimage (row,col)= sum (sum(double(image(row-1: row+1, col-1: col+1 )) .* filter )); 
    end
end 
image =uint8(image);
figure,imshow (outputimage);
imwrite(outputimage, 'Edges.png')
imUint = uint8(outputimage);
imEn = imadd(image,imUint);
figure,imshow (imEn);
imwrite(imEn,'Edge_enhanced.png');