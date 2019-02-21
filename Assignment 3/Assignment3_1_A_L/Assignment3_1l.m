img = imread('AtlasMercury.tif');
img2 = uint8(size(img));
gam = 1/2;
for i=1:3
    for j=1:413
        for k=1:284
            img2(j,k,i)= 255*((double(img(j,k,i))/255)^double(1/gam));
        end
    end    
        
end

imshow(img);
figure;
imshow(img2);
imwrite(img2,'Dec_gamma.png');