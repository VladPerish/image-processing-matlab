I = imread('Board.bmp');
 
[j, k] = size(I);
 
p = input('Enter ratio =  ');
x_new = j*p;
y_new = k*p;
 
%Determine the ratio of the old dimensions compared to the new dimensions
 
x_scale = j./x_new;
y_scale = k./y_new;
 
%Declare and initialize an output image buffer
 
M = zeros(x_new,y_new);
 
%Generate the output image
 
for count1 = 1:x_new
 for count2 = 1:y_new
 M(count1,count2) = I(count1.*x_scale,count2.*y_scale);
 end
end
 
%Display the two images side-by-side for a few seconds, then close
 
subplot(1,2,1); imagesc(I);colormap gray; axis tight;
subplot(1,2,2); imagesc(M);colormap gray; axis tight;
imwrite(M,gray(256),'scaling.jpg');
