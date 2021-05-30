[x, map] = imread('lena.png');
y = uint8(zeros(size(x)));
z = x;

[Rows,Cols] = size(x);
M = 10;

for i = 1:Rows
    for j = 1:Cols
        if (j <= M-1)
            for k = 1:M-1
                y(i,j) = y(i,j)+x(i,k);
            end
        else
            for k = 0:M-1
                y(i,j) = y(i,j)+x(i,j-k);
            end
        end
        y(i,j) = y(i,j)/M;
    end
end

fileName = strcat('LPF_',string(M),'.jpg');
imwrite(y,map,fileName);

graph_x = 1:1:256;
plot(graph_x,z(30,:),graph_x,y(30,:))