img = imread('AtlasMercury.tif');
img = im2double(img); % Cast to double.
channelCount = size(img ,3);
%f3 = zeros(size(f1,1) ,size(f1, 2), size(f1, 3));
for i = 1:channelCount
    fmatrix = img(:,:,i);
    min1 = min(min(fmatrix));
    max1 = max(max(fmatrix));
    f2 = round( ((fmatrix - min1)*255)/(max1- min1));
end

   