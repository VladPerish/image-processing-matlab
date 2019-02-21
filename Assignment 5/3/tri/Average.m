im1 = imread('IMG_20181125_234224_001.jpg');
im2 = imread('IMG_20181125_234224_002.jpg');
im3 = imread('IMG_20181125_234224_003.jpg');
im4 = imread('IMG_20181125_234224_004.jpg');
im5 = imread('IMG_20181125_234224_005.jpg');
im6 = imread('IMG_20181125_234224_006.jpg');
im7 = imread('IMG_20181125_234224_007.jpg');
im8 = imread('IMG_20181125_234224_008.jpg');
im9 = imread('IMG_20181125_234224_009.jpg');
im10 = imread('IMG_20181125_234224_010.jpg');
im11 = imread('IMG_20181125_234224_011.jpg');
im12 = imread('IMG_20181125_234224_012.jpg');
im13 = imread('IMG_20181125_234224_013.jpg');
im14 = imread('IMG_20181125_234224_014.jpg');
im15 = imread('IMG_20181125_234224_015.jpg');
im16 = imread('IMG_20181125_234224_016.jpg');
im17 = imread('IMG_20181125_234224_017.jpg');
im18 = imread('IMG_20181125_234224_018.jpg');

avg = uint8(zeros(size(im1)));
[rows,columns,channels] = size(avg);

for k = 1:channels
    for i = 1:rows
        for j = 1: columns
            avg(i,j,k) = (im1(i,j,k)/18+im2(i,j,k)/18+im3(i,j,k)/18+im4(i,j,k)/18+im5(i,j,k)/18+im6(i,j,k)/18+im7(i,j,k)/18+im8(i,j,k)/18+im9(i,j,k)/18+im10(i,j,k)/18+im11(i,j,k)/18+im12(i,j,k)/18+im13(i,j,k)/18+im14(i,j,k)/18+im11(i,j,k)/18+im12(i,j,k)/18+im13(i,j,k)/18+im14(i,j,k)/18+im15(i,j,k)/18+im16(i,j,k)/18+im17(i,j,k)/18+im18(i,j,k)/18);
        end
    end
    
end
imwrite(avg,'avg18.jpg');

