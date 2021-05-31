[x, map] = imread('lena.png');
original = x;
y = uint8(zeros(size(x)));

[Rows,Cols] = size(x);
z = [];
b = 9;

for i = 1:Rows
    z(i,:) = [zeros(1,1), x(i,:), zeros(1,1)];
end

z = [zeros(1,258); z ; zeros(1,258)];

for i = 2:Rows+1
    for j = 2:Cols+1
        y(i-1,j-1) = 3*z(i,j)-(z(i+1,j) + z(i-1,j) + z(i,j+1) + z(i,j-1)) + ...
        0.25 * (z(i+1,j+1) + z(i+1,j-1) + z(i-1,j+1) + z(i-1, j-1));
    end
end

k = x + b * y;

fileName = strcat('HPF_',string(b),'.jpg');
imwrite(k,map,fileName);