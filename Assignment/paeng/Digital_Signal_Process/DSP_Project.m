clear all;

[x, map] = imread('Lena.png');
y = uint8(zeros(size(x)));
[xRow, xCol] = size(x);

t= [1:xRow];
n = length(t);
f = -n/2:(n/2)-1;
point = 60;



for i =1:xCol
    input = [zeros(1, point-1), x(i,:)];
    for j = 1:xRow
        for k = 1:point
            y(i,j) = y(i,j) + input(j + k - 1);
        end
        y(i,j) = y(i,j) / point;
    end
end

fileName = strcat('LenaOutupu_',string(point),'_point.jpg');
imwrite(y,map, fileName);

