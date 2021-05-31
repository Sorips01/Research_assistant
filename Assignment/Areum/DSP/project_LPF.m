[x, map] = imread('lena.png');
y = uint8(zeros(size(x)));
 
[Rows,Cols] = size(x);
M = 20;
 
for i = 1:Rows
    z = [zeros(1,M-1), x(i,:)];
    for j = 1:Cols
        for k = 1:M
            y(i,j) = y(i,j) + z(1,j+k-1);
        end
        y(i,j) = y(i,j)/M;
    end
end
 
z = x;

for i = 1:floor(M/2)
    y(:,i) = [];
end
 
fileName = strcat('LPF_',string(M),'.jpg');
imwrite(y,map,fileName);
