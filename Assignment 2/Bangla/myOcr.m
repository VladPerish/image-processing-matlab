%% Read Image
Inputimage=imread('Bangla_testocr.bmp');

%% Convert to binary image
threshold = graythresh(Inputimage);
Inputimage =~im2bw(Inputimage,threshold)

%% Remove all object containing fewer than 30 pixels
Inputimage = bwareaopen(Inputimage,30);
pause(1)

%% Objects extraction
% figure
for n=1:Ne
  [r,c] = find(L==n);
  n1=Inputimage(min(r):max(r),min(c):max(c));
%   imshow(~n1);
  imwrite(n1,strcat(num2str(n),'.bmp'));
%   pause(0.5)
end
