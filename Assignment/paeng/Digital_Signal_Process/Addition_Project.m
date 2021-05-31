clear all;

[x, map] = imread('Lena.png');
%% Load LPF 
% load(fullfile(pwd, '\data\3_point_gx.mat'));
% load(fullfile(pwd, '\data\3_point_gy.mat'));
% load(fullfile(pwd, '\data\7_point_gx.mat'));
% load(fullfile(pwd, '\data\7_point_gy.mat'));


%% Load HPF
% load(fullfile(pwd, '\data\b_is_2_gx.mat'));
% load(fullfile(pwd, '\data\b_is_2_gz.mat'));
% load(fullfile(pwd, '\data\b_is_7_gx.mat'));
% load(fullfile(pwd, '\data\b_is_7_gz.mat'));

%% main
p = 1;
b = 1;
result = hpf_paeng(lpf_paeng(x,p),b);
fileName = strcat('Addition/Addition_LenaOutuput.jpg');
imwrite(result, map, fileName);

%% LPF
function y = lpf_paeng(img, point)
    x = img;
    y = uint8(zeros(size(x)));
    [xRow, xCol] = size(x);
    
    for ii =1:xRow
        input = [zeros(1, point-1), x(ii,:)];
        for jj = 1:xCol
            for kk = 1:point
                y(ii,jj) = y(ii,jj) + input(jj + kk - 1);
            end
            y(ii,jj) = y(ii,jj) / point;
        end
    end
end
%% HPF
function z = hpf_paeng(img, b)
    x = img;
    y = uint8(zeros(size(x)));
    [xRow, xCol] = size(x);
    origin = x;
    x = [zeros(1,xCol); x; zeros(1,xCol)];
    x = [zeros(xRow + 2,1), x, zeros(xRow + 2,1)];
        
    
    for ii = (2):(xRow+1)
        for jj = (2):(xCol+1)
            y(ii - 1,jj - 1) = 3 * x(ii, jj) - (x(ii + 1, jj) + x(ii - 1, jj) + x(ii, jj + 1) + x(ii, jj - 1)) + (0.25) * (x(ii + 1, jj + 1) + x(ii + 1, jj - 1) + x(ii - 1, jj + 1) + x(ii - 1, jj - 1));
        end
    end

    z = origin + b * y;
end