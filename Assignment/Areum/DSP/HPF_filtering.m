[x, map] = imread('lena.png');
y = uint8(zeros(size(x)));

[Rows,Cols] = size(x);
z = [];
b = 2;

for i = 1:Rows
    z(i,:) = [zeros(1,1), x(i,:), zeros(1,1)];
end

z = [zeros(1,258); z ; zeros(1,258)];

for i = 2:Rows
    for j = 2:Cols
        y(i,j) = 3*z(i,j)-(z(i+1,j) + z(i-1,j) + z(i,j+1) + z(i,j-1)) + ...
        0.25 * (z(i+1,j+1) + z(i+1,j-1) + z(i-1,j+1) + z(i-1, j-1));
        
        k(i,j) = x(i,j) + b * y(i,j);
    end
end

fileName = strcat('HPF_no_',string(b),'.jpg');
imwrite(k,map,fileName);