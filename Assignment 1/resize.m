a=imread('peppers.png');
p= size(a)
[rows,columns,layers]=size(a)
rows = rows/2
columns = columns/2
i=1;j=1;k=1;
c=zeros(rows,columns,layers);
c=uint8(c);
figure

imshow(a) % Display BEFORE casting to double.
% imshow(c)
a = double(a);
for x=1:2:rows-1
	for y=1:2:columns-1
		for z=1:layers
			c(i,j,k)=1/4*(a(x,y,z)+a(x,y+1,z)+a(x+1,y,z)+a(x+1,y+1,z));
%             c(i,j,k)=(a(x,y,z));
			k=k+1;
		end
		j=j+1;
		k=1;
	end
	i=i+1;
	j=1;
	k=1;
end
axis on;
figure, 
imshow(c)
axis on;