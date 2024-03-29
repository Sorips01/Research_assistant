[x, map] = imread('lena.png');
y = uint8(zeros(size(x)));

[Rows,Cols] = size(x);
M = 10;

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

%% 지연 연산기 사용 안함
% graph_x = 1:1:256;
% plot(graph_x,z(30,:),graph_x,y(30,:))
% 
% fileName = strcat('LPF_',string(M),'.jpg');
% imwrite(y,map,fileName);

%% 지연 연산기 사용

for i = 1:floor(M/2)
    y(:,i) = [];
end

graph_x = 1:1:256;
graph_x2 = 1:1:(256-floor(M/2));
plot(graph_x,z(30,:),graph_x2,y(30,:))

fileName = strcat('LPF_',string(M),'.jpg');
imwrite(y,map,fileName);