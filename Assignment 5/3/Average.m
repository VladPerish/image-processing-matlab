im1 = imread('IMG_20181125_234836_001.jpg');
im2 = imread('IMG_20181125_234836_002.jpg');
im3 = imread('IMG_20181125_234836_003.jpg');
im4 = imread('IMG_20181125_234836_004.jpg');
im5 = imread('IMG_20181125_234836_005.jpg');
im6 = imread('IMG_20181125_234836_006.jpg');
im7 = imread('IMG_20181125_234836_007.jpg');
avg = uint8(zeros(size(im1)));
[rows,columns,channels] = size(avg);

for k = 1:channels
    for i = 1:rows
        for j = 1: columns
            avg(i,j,k) = (1/7)*(im1(i,j,k)+im2(i,j,k)+im3(i,j,k)+im4(i,j,k)+im5(i,j,k)+im6(i,j,k)+im7(i,j,k));
        end
    end
    
end
imwrite(avg,'avg.jpg');