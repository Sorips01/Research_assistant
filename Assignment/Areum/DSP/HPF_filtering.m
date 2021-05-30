[x, map] = imread('lena.png');
original = x;
y = uint8(zeros(size(x)));

[Rows,Cols] = size(x);
z = [];
b = 50;

for i = 1:Rows
    z(i,:) = [zeros(1,1), x(i,:), zeros(1,1)];
end

z = [zeros(1,258); z ; zeros(1,258)];

for i = 2:Rows+1
    for j = 2:Cols+1
        y(i,j) = 3*z(i,j)-(z(i+1,j) + z(i-1,j) + z(i,j+1) + z(i,j-1)) + ...
        0.25 * (z(i+1,j+1) + z(i+1,j-1) + z(i-1,j+1) + z(i-1, j-1));
        
        k(i-1,j-1) = x(i-1,j-1) + b * y(i,j);
    end
end

fileName = strcat('HPF_',string(b),'.jpg');
imwrite(k,map,fileName);

graph_x = 1:1:256;
graph_x2 = 1:1:257;
plot(graph_x,original(30,:),graph_x2,k(30,:))