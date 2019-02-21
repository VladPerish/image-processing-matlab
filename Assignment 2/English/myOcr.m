%% Read Image

main;
clc;
mkdir Alphabets;
for fileNo = 1:kap-1
    
    fName = strcat('L',num2str(fileNo),'.bmp');
    Inputimage=imread(fName);
    %% Show image
    figure(1)
    imshow(Inputimage);
    title('INPUT IMAGE WITH NOISE')

    %% Convert to binary image
    threshold = graythresh(Inputimage);
    Inputimage =~im2bw(Inputimage,threshold)

    %% Remove all object containing fewer than 30 pixels
    Inputimage = bwareaopen(Inputimage,30);
    pause(1);

    %% Label connected components
     [L, Ne]=bwlabel(Inputimage);

    %% Objects extraction
    % figure
    cd Alphabets;
    for n=1:Ne
      [r,c] = find(L==n);
      n1=Inputimage(min(r):max(r),min(c):max(c));
    %   imshow(~n1);
      imwrite(n1,strcat('L',num2str(fileNo),'_',num2str(n),'.tif'));
    %   pause(0.5)
    end
    cd .. ;
    
end