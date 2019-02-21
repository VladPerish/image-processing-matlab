
	
%Import my original picture file
 
 
I = imread('Board.bmp');
 
%Convert image to grayscale (intensity) values for simplicity (for now)
 
 

%Determine the dimensions of the source image
 
 
%Note that we will have three values - width, height, and the number
 
 
%of color vectors, 3
 
 
[j k] = size(I);
 
%Specify the new image dimensions we want for our larger output image
p = input('Ratio= ');
 
x_new = j*p;
 
y_new = k*p;
 
%Determine the ratio of the old dimensions compared to the new dimensions
 
 
%Referred to as S1 and S2 in my tutorial
 
 
x_scale = x_new./(j-1);
 
y_scale = y_new./(k-1);
 
%Declare and initialize an output image buffer
 
 
M = zeros(x_new,y_new);
 
%Generate the output image
 
 
for count1 = 0:x_new-1
 
 for count2 = 0:y_new-1
 
 M(count1+1,count2+1) = I(1+round(count1./x_scale),1+round(count2./y_scale));
 
 end
 
end
 
%Display the two images side-by-side for a few seconds, then close
 
 
subplot(1,2,1); imagesc(I);colormap gray;
 
subplot(1,2,2); imagesc(M);colormap gray;
 
%Write the images to files
 
 
imwrite(I,gray(256),'input.jpg');
 
imwrite(M,gray(256),'output.jpg');
