clear all;
close all;

x=-14:2:14;
LineWidth = 1;
lim_y = 1E-5;

antennaCount = ["_4x4","_4x8" ,"_8x8", "_8x16","_16x16" ];
% loading mat file 4x4

% loadName = strcat(pwd, '\result\ISDIC', antennaCount(1), '_Original.mat');
% load(fullfile(loadName));
% Original_4x4 = length_normalize(x, result(:,5)');
% loadName = strcat(pwd, '\result\ISDIC', antennaCount(1), '_QR','.mat');
% load(fullfile(loadName));
% QR_4x4 = length_normalize(x, result(:,5)');

% loading mat file 4x8

loadName = strcat(pwd, '\result\ISDIC', antennaCount(2), '_Original.mat');
load(fullfile(loadName));
Original_4x8 = length_normalize(x, result(:,5)');
Original_4x8_iter_1 = length_normalize(x, result(:,1)');

loadName = strcat(pwd, '\result\ISDIC', antennaCount(2), '_QR','.mat');
load(fullfile(loadName));
QR_4x8 = length_normalize(x, result(:,5)');
QR_4x8_iter_1 = length_normalize(x, result(:,1)');

% loading mat file 8x8

loadName = strcat(pwd, '\result\ISDIC', antennaCount(3), '_Original.mat');
load(fullfile(loadName));
Original_8x8 = length_normalize(x, result(:,5)');
Original_8x8_iter_1 = length_normalize(x, result(:,1)');

loadName = strcat(pwd, '\result\ISDIC', antennaCount(3), '_QR','.mat');
load(fullfile(loadName));
QR_8x8 = length_normalize(x, result(:,5)');
QR_8x8_iter_1 = length_normalize(x, result(:,1)');

% loading mat file 8x16

% loadName = strcat(pwd, '\result\ISDIC', antennaCount(4), '_Original.mat');
% load(fullfile(loadName));
% Original_8x16 = length_normalize(x, result(:,5)');
% 
% loadName = strcat(pwd, '\result\ISDIC', antennaCount(4), '_QR','.mat');
% load(fullfile(loadName));
% QR_8x16 = length_normalize(x, result(:,5)');

% loading mat file 16x16

% loadName = strcat(pwd, '\result\ISDIC', antennaCount(5), '_Original.mat');
% load(fullfile(loadName));
% Original_16x16 = length_normalize(x, result(:,5)');
% 
% loadName = strcat(pwd, '\result\ISDIC', antennaCount(5), '_QR','.mat');
% load(fullfile(loadName));
% QR_16x16 = length_normalize(x, result(:,5)');


% Draw
f1 = figure;
% semilogy(x, Original_4x4, 'LineWidth', LineWidth);
% hold on;
% semilogy(x, QR_4x4, 'LineWidth', LineWidth);
% hold on;

%% iteration 1

semilogy(x, Original_4x8_iter_1, 'LineWidth', LineWidth);
hold on;
semilogy(x, QR_4x8_iter_1, 'LineWidth', LineWidth);
hold on;

semilogy(x, Original_8x8_iter_1, 'LineWidth', LineWidth);
hold on;
semilogy(x, QR_8x8_iter_1, 'LineWidth', LineWidth);
hold on;

% semilogy(x, Original_8x16, 'LineWidth', LineWidth);
% hold on;
% semilogy(x, QR_8x16, 'LineWidth', LineWidth);
% hold on;
% 
% semilogy(x, Original_16x16, 'LineWidth', LineWidth);
% hold on;
% semilogy(x, QR_16x16, 'LineWidth', LineWidth);
% hold on;


%% iteration 5

semilogy(x, Original_4x8, 'LineWidth', LineWidth);
hold on;
semilogy(x, QR_4x8, 'LineWidth', LineWidth);
hold on;

semilogy(x, Original_8x8, 'LineWidth', LineWidth);
hold on;
semilogy(x, QR_8x8, 'LineWidth', LineWidth);
hold on;



xlim([-14 10]);
ylim([lim_y 1]);
ylabel('Average BER');
xlabel('SNR');
% legend('Original 4x4','QR 4x4','Original 4x8','QR 4x8', 'Original 8x8','QR 8x8', 'Original 8x16','QR 8x16', 'Original 16x16','QR 16x16');
legend('Original 4x8 Iter:1','Proposed 4x8 Iter:1', 'Original 8x8 Iter:1','Proposed 8x8 Iter:1', 'Original 4x8 Iter:5','Proposed 4x8 Iter:5', 'Original 8x8 Iter:5','Proposed 8x8 Iter:5');
title('QR Algorithm');