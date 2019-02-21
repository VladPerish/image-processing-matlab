% Read image
i=imgetfile();
input=imread(i);
figure, imshow(input), title('Original Image');

% Deskew a document
[ im, theta ] = imdeskew( input );
figure, imshow(im), title('Deskewed image');

if size(im,3)==3 % RGB image %% Convert to gray scale
    im=rgb2gray(im);
end

%% Remove all object containing fewer than 60 pixels
im = bwareaopen(im,60); 
a=(im);
ijk=~a;
L=sum(ijk,2);
L=0;
measurements = regionprops(L, 'PixelIdxList','Area','BoundingBox');
% Get indexes of those regions that are >= 20 in length.
fiveLongRegions = find([measurements.Area] >= 5);
theIndexes = vertcat(measurements(fiveLongRegions).PixelIdxList);
c=a;
c(theIndexes,:)=0;
figure, imshow(c);
title('AREA OF INTEREST FOR LINE SEGMENT');

%Segmentation of line:
[x,y]=size(c);
mat1=sum(c,2);%sum the elements of bwrowise and save into column matrix mat1
mat2=y-mat1;%subtract each element of the sum matrix(mat1) from the width length(no. of columns)
mat3=mat2~=0;
mat4=diff(mat3);
index1=find(mat4);
[q,w]=size(index1);%size of index2 matrix is q*w
kap=1;
lam=1;
%iii=1;
%ii=1;
while kap<((q/2)+1);%number of loops=number of lines
    k=1;
    mat5=([]);
       for j=(index1(lam)+1):1:index1(lam+1)
         mat5(k,:)=a(j,:); %store the line segmented matrix
           k=k+1;
       end
         
        number =  num2str(kap);              
        imwrite(mat5,strcat('L', number, '.bmp'));   
        figure, imshow(mat5);
        lam=lam+2;   
        kap=kap+1;
         
%        imsave();          
end
%deskew

function [ im, theta ] = imdeskew( src, max_angle, resolution, plotOn ) 

% 0. parameter settings
if nargin <= 1
    max_angle   = 15;
    resolution  = .5;
    plotOn      = 1;
elseif nargin <= 2
    resolution  = .5;
    plotOn      = 1;
elseif nargin <= 3
    plotOn      = 1;
else
    error('unsupported input format')
end
% input settings
if size( src, 3 ) > 1 
    display('warning: automatic converting color image to binary')
    gray = rgb2gray( src );
    src  = gray > graythresh( gray ) * 255;
else
    if ~islogical( src )
        display('warning: automatic converting grayscale image to binary')
        src = src > graythresh( src ) * 255;
    end
end
% 1. extract black text pixels for analysis
[ h, w ]    = size( src );
[ text_x, text_y ] = ind2sub(  [ h,w ], find( src(:) == 0 ) );
% 2. compute the information entroy of a projection profile
angles = -max_angle : resolution : max_angle;
cx  = h/2;
cy  = w/2;
len = size( text_x, 1 );
hist_to_prob = @( h ) ( h( h ~= 0 ) / len );
score = [];
for a = angles
    sin_a = sin( a / 180 * pi );
    cos_a = cos( a / 180 * pi );
    sx    = round( ( text_x - cx ) * cos_a + ( text_y -cy ) * sin_a + cx );
    freq  = hist( sx, unique(sx) );
    prob  = hist_to_prob( freq );
    entropy = -prob .* log( prob );
    score(end+1) = sum( entropy(:) );
end
% 3. generate output
[ val, min_idx ] = min( score );
theta = -angles( min_idx );
im = not( imrotate( not( src ), theta, 'loose' ) );
if plotOn
    figure,subplot(131),plot( -angles, score ), xlabel( 'deskew angle: degree' ), ylabel( 'projection profile entropy ' );
    hold on, line( [ -angles( min_idx ), -angles( min_idx )]' , [ min( score )-.1, max( score ) ]', 'color',[1,0,0] )
    hold on, text(  -angles( min_idx )-1, max( score )-.2 , 'optimal deskew angle' ),axis square
    subplot(132),imshow( imerode(src, ones(3) ) ); title( 'before deskew ');
    subplot(133),imshow( imerode(im, ones(3) ) ); title( 'after deskew' );
end

end