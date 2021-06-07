% DSP_Project_1
clear all;

%% init
[x, map] = imread('Lena.png');
y = uint8(zeros(size(x)));
[xRow, xCol] = size(x);

n = xRow;
t = 1:n;

point = 3;

%% Zero Padding
for ii =1:xRow
    input = [zeros(1, point-1), x(ii,:)];
    for jj = 1:xCol
        for kk = 1:point
            y(ii,jj) = y(ii,jj) + input(jj + kk - 1);
        end
        y(ii,jj) = y(ii,jj) / point;
    end
end

gx = reshape(x, 1,[]);  % Graph X
gy = reshape(y, 1,[]);  % Graph y
%% file save
fileName = strcat('LPF/LenaOutuput_',string(point),'_point_LPF.jpg');
imwrite(y, map, fileName);

% matFileName_gx = strcat(pwd,'\data\', string(point), '_point_gx.mat');
% matFileName_gy = strcat(pwd,'\data\', string(point), '_point_gy.mat');
% save(matFileName_gx, 'gx');
% save(matFileName_gy, 'gy');

%% Origin & 3-Point Graph
% load(fullfile(pwd, '\data\3_point_gx.mat'));
% load(fullfile(pwd, '\data\3_point_gy.mat'));
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