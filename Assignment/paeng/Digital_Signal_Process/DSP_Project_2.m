clear all;

%% init
[x, map] = imread('Lena.png');
origin = x;
y = uint8(zeros(size(x)));
b = 10;
[xRow, xCol] = size(x);

n = xRow;
f = -n/2:(n/2)-1;

%% Add Zero Padding
x = [zeros(1,xCol); x; zeros(1,xCol)];
x = [zeros(xRow + 2,1), x, zeros(xRow + 2,1)];
    
%% main
for ii = (2):(xRow+1)
    for jj = (2):(xCol+1)
        y(ii - 1,jj - 1) = 3 * x(ii, jj) - (x(ii + 1, jj) + x(ii - 1, jj) + x(ii, jj + 1) + x(ii, jj - 1)) + (0.25) * (x(ii + 1, jj + 1) + x(ii + 1, jj - 1) + x(ii - 1, jj + 1) + x(ii - 1, jj - 1));
    end
end

z = origin + b * y;

gx = reshape(origin, 1,[]);  % Graph X
gz = reshape(z, 1,[]);  % Graph z
%% file save
fileName = strcat('HPF/LenaOutuput_',string(b),'_HPF.jpg');
% imwrite(z, map, fileName);

matFileName_gx = strcat(pwd,'\data\', string(point), '_point_gx.mat');
matFileName_gz = strcat(pwd,'\data\', string(point), '_point_gz.mat');
save(matFileName_gx, 'gx');
save(matFileName_gz, 'gz');

%% Origin & 3-Point Graph
% load(fullfile(pwd, '\data\3_point_gx.mat'));
% load(fullfile(pwd, '\data\3_point_gz.mat'));
% subplot(2,1,1);
% plot(1:length(gx), gx, 1:length(gy), gy);
% xlim([0 inf]);
% legend('Origin', '3-Point');

% subplot(2,1,2);
% fx = fftshift(fft(gx));
% fy = fftshift(fft(gy));
% f = -(length(gx))/2:(length(gx)/2)-1;
% plot(f,abs(fx), f, abs(fy));
% xlim([-inf inf]);
% legend('Origin', '3-Point');

%% Origin & 7-Point Graph
% load(fullfile(pwd, '\data\7_point_gx.mat'));
% load(fullfile(pwd, '\data\7_point_gy.mat'));
% 
% subplot(2,1,1);
% plot(1:length(gx), gx, 1:length(gy), gy);
% xlim([0 inf]);
% legend('Origin', '7-Point');
% 
% subplot(2,1,2);
% fx = fftshift(fft(gx));
% fy = fftshift(fft(gy));
% f = -(length(gx))/2:(length(gx)/2)-1;
% plot(f,abs(fx), f, abs(fy));
% xlim([-inf inf]);
% legend('Origin', '7-Point');