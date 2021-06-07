% DSP_Project_2
clear all;

%% init
[x, map] = imread('Lena.png');
origin = x;
y = uint8(zeros(size(x)));
b = 2;
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
imwrite(z, map, fileName);

% matFileName_gx = strcat(pwd,'\data\','b_is_' ,string(b), '_gx.mat');
% matFileName_gz = strcat(pwd,'\data\','b_is_' ,string(b), '_gz.mat');
% save(matFileName_gx, 'gx');
% save(matFileName_gz, 'gz');

%% Origin & b=2 Graph
% load(fullfile(pwd, '\data\b_is_2_gx.mat'));
% load(fullfile(pwd, '\data\b_is_2_gz.mat'));
% subplot(2,1,1);
% plot(1:length(gx), gx, 1:length(gz), gz);
% xlim([0 inf]);
% legend('Origin', 'b = 2');

% subplot(2,1,2);
% fx = fftshift(fft(gx));
% fz = fftshift(fft(gz));
% f = -(length(gx))/2:(length(gx)/2)-1;
% plot(f,abs(fx), f, abs(fz));
% xlim([-inf inf]);
% legend('Origin', 'b = 2');

%% Origin & b=7 Graph
% load(fullfile(pwd, '\data\b_is_7_gx.mat'));
% load(fullfile(pwd, '\data\b_is_7_gz.mat'));
% subplot(2,1,1);
% plot(1:length(gx), gx, 1:length(gz), gz);
% xlim([0 inf]);
% legend('Origin', 'b = 7');

% subplot(2,1,2);
% fx = fftshift(fft(gx));
% fz = fftshift(fft(gz));
% f = -(length(gx))/2:(length(gx)/2)-1;
% plot(f,abs(fx), f, abs(fz));
% xlim([-inf inf]);
% legend('Origin', 'b = 7');