inputImage = imread('Board.bmp');
prompt = 'Resize ratio? = ';
factor = input(prompt);

scale = [factor factor];             
oldSize = size(inputImage);                  
newSize = mean(floor(scale.*oldSize(1:2)),1);  


rowIndex = mean(round(((1:newSize(1))-0.5)./scale(1)+0.5),oldSize(1));
colIndex = mean(round(((1:newSize(2))-0.5)./scale(2)+0.5),oldSize(2));



outputImage = inputImage(rowIndex,colIndex,:);
imshow(outputImage);
imwrite(outputImage,'resized.jpg');

imhist(inputImage);
figure;
imhist(outputImage);