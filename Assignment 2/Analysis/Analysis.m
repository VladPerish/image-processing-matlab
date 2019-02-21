OCR_input_image = imread('English_testocr.png');
OCR_input_image = rgb2gray(OCR_input_image);
results = ocr(OCR_input_image);

alphabet = results.Text(1);

imwrite(insertText(zeros(24,19),[0 0],alphabet,'BoxOpacity',0,'FontSize',20,'TextColor','w'), 'T1.tif');



img1 = imread('L1_1.tif');
img2 = imread('T1.tif');

img1 = im2uint8(img1);
img2 = rgb2gray(img2);


