IM = imread('Board.bmp');
NewImage = (IM(1:2:end, 1:2:end) + IM(2:2:end, 1:2:end) + IM(1:2:end, 2:2:end) + IM(2:2:end, 2:2:end)) / 8;
% imwrite(NewImage,'average.jpg');
imwrite(NewImage,gray(256),'average.jpg');