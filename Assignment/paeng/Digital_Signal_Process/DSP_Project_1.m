clear all;

%% init
[x, map] = imread('Lena.png');
y = uint8(zeros(size(x)));
[xRow, xCol] = size(x);

t= [1:xRow];
n = length(t);
f = -n/2:(n/2)-1;
point = 10;

%% Zero Padding
% for ii =1:xRow
%     input = [zeros(1, point-1), x(ii,:)];
%     for jj = 1:xCol
%         for kk = 1:point
%             y(ii,jj) = y(ii,jj) + input(jj + kk - 1);
%         end
%         y(ii,jj) = y(ii,jj) / point;
%     end
% end
%% No Zero Padding
for ii = 1:(xRow)
    for jj = point:(xCol)
        for kk = 0:(point-1)
            y(ii,jj) = y(ii,jj) + x(ii,jj - kk);
        end
        y(ii,jj) = y(ii,jj) / point;
    end
end

for ii = 1:(xRow)
   for jj = 1:(point-1)
       for kk = 0:(jj-1)
            y(ii,jj) = y(ii,jj) + x(ii,jj - kk);
       end
       y(ii,jj) = y(ii,jj) / point;
   end
end

%% file save
fileName = strcat('LenaOutuput_',string(point),'_point_LPF.jpg');
imwrite(y, map, fileName);

