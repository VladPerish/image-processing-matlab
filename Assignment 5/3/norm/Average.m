im1 = imread('IMG_20181125_234836_001.jpg');
im2 = imread('IMG_20181125_234836_002.jpg');
im3 = imread('IMG_20181125_234836_003.jpg');
im4 = imread('IMG_20181125_234836_004.jpg');
im5 = imread('IMG_20181125_234836_005.jpg');
im6 = imread('IMG_20181125_234836_006.jpg');
im7 = imread('IMG_20181125_234836_007.jpg');
im8 = imread('IMG_20181125_234836_008.jpg');
im9 = imread('IMG_20181125_234836_009.jpg');
im10 = imread('IMG_20181125_234836_010.jpg');
im11 = imread('IMG_20181125_234836_011.jpg');
im12 = imread('IMG_20181125_234836_012.jpg');
im13 = imread('IMG_20181125_234836_013.jpg');
im14 = imread('IMG_20181125_234836_014.jpg');
im15 = imread('IMG_20181125_234836_015.jpg');
im16 = imread('IMG_20181125_234836_016.jpg');


avg = uint8(zeros(size(im1)));
[rows,columns,channels] = size(avg);

for k = 1:channels
    for i = 1:rows
        for j = 1: columns
            avg(i,j,k) = (im1(i,j,k)/16+im2(i,j,k)/16+im3(i,j,k)/16+im4(i,j,k)/16+im5(i,j,k)/16+im6(i,j,k)/16+im7(i,j,k)/16+im8(i,j,k)/16+im9(i,j,k)/16+im10(i,j,k)/16+im11(i,j,k)/16+im12(i,j,k)/16+im13(i,j,k)/16+im14(i,j,k)/16+im11(i,j,k)/16+im12(i,j,k)/16+im13(i,j,k)/16+im14(i,j,k)/16+im15(i,j,k)/16+im16(i,j,k)/16);
        end
    end
    
end
imwrite(avg,'avg.jpg');