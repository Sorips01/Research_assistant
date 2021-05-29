clear all;

%% init
[x, map] = imread('Lena.png');
y = uint8(zeros(size(x)));
[xRow, xCol] = size(x);

t= [1:xRow];
n = length(t);
f = -n/2:(n/2)-1;
point = 60;


%% No Zero Padding
for ii = (2):(xRow-1)
    for jj = (2):(xCol-1)
        y(ii,jj) = 3 * x(ii, jj) - (x(ii + 1, jj) + x(ii - 1, jj) + x(ii, jj + 1) + x(ii, jj - 1)) + (0.25) * (x(ii + 1, jj + 1) + x(ii + 1, jj - 1) + x(ii - 1, jj + 1) + x(ii - 1, jj - 1));
    end
end
y(1,1) = 3 * x(1, 1) - (x(2, 1) + x(1, 2)) + (0.25) * (x(2, 2));
y(xRow,xCol) = 3 * x(xRow, xCol) - (x(xRow - 1, xCol) + x(xRow, xCol - 1)) + (0.25) * (x(xRow - 1, xCol - 1));

%% file save
fileName = strcat('LenaOutuput_',string(point),'_point_LPF.jpg');
imwrite(y, map, fileName);

