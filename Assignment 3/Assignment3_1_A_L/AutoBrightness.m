input_image =imread('Dec_bright.png');
output_img = 'autoImg.png';



my_limit=0.5;
if size(input_image,3)==3 
    a=rgb2ntsc(input_image);
else
    a=double(input_image)./255;
end
mean_adjustment=my_limit-mean(mean(a(:,:,1)));
a(:,:,1)=a(:,:,1)+mean_adjustment*(1-a(:,:,1));
if size(input_image,3)==3 
    a=ntsc2rgb(a);
end
imwrite(uint8(a.*255),output_img);
