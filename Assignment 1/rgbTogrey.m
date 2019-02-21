rgbImage = imread('lena.png');

  
      % It's color, need to convert it to grayscale.
      redChannel = rgbImage(:, :, 1);
      greenChannel = rgbImage(:, :, 2);
      blueChannel = rgbImage(:, :, 3);
      % Do the weighted sum.
      grayImage = .299*double(redChannel) + ...
                  .587*double(greenChannel) + ...
                  .114*double(blueChannel);
      % You probably want to convert it back to uint8 so you can display it.
      grayImage = uint8(grayImage);
imshow(grayImage);
imwrite(grayImage,'Lena_grey.png');
