clear all;
close all;

x=0:2:20;
LineWidth = 1;
lim_y = 1E-8;

antennaCount = ["_4x4","_4x8" ,"_8x8", "_8x16","_16x16" ];
% loading mat file 4x4

loadName = strcat(pwd, '\result\ISDIC', antennaCount(1), '_Original.mat');
load(fullfile(loadName));
Original_4x4 = length_normalize(x, result(:,5)');
loadName = strcat(pwd, '\result\ISDIC', antennaCount(1), '_QR','.mat');
load(fullfile(loadName));
QR_4x4 = length_normalize(x, result(:,5)');

% loading mat file 4x8

loadName = strcat(pwd, '\result\ISDIC', antennaCount(2), '_Original.mat');
load(fullfile(loadName));
Original_4x8 = length_normalize(x, result(:,5)');

loadName = strcat(pwd, '\result\ISDIC', antennaCount(2), '_QR','.mat');
load(fullfile(loadName));
QR_4x8 = length_normalize(x, result(:,5)');

% loading mat file 8x8

loadName = strcat(pwd, '\result\ISDIC', antennaCount(3), '_Original.mat');
load(fullfile(loadName));
Original_8x8 = length_normalize(x, result(:,5)');

loadName = strcat(pwd, '\result\ISDIC', antennaCount(3), '_QR','.mat');
load(fullfile(loadName));
QR_8x8 = length_normalize(x, result(:,5)');

% loading mat file 8x16

loadName = strcat(pwd, '\result\ISDIC', antennaCount(4), '_Original.mat');
load(fullfile(loadName));
Original_8x16 = length_normalize(x, result(:,5)');

loadName = strcat(pwd, '\result\ISDIC', antennaCount(4), '_QR','.mat');
load(fullfile(loadName));
QR_8x16 = length_normalize(x, result(:,5)');

% loading mat file 16x16

loadName = strcat(pwd, '\result\ISDIC', antennaCount(5), '_Original.mat');
load(fullfile(loadName));
Original_16x16 = length_normalize(x, result(:,5)');

loadName = strcat(pwd, '\result\ISDIC', antennaCount(5), '_QR','.mat');
load(fullfile(loadName));
QR_16x16 = length_normalize(x, result(:,5)');


% Draw
f1 = figure;
semilogy(x, Original_4x4, 'LineWidth', LineWidth);
hold on;
semilogy(x, QR_4x4, 'LineWidth', LineWidth);
hold on;

semilogy(x, Original_4x8, 'LineWidth', LineWidth);
hold on;
semilogy(x, QR_4x8, 'LineWidth', LineWidth);
hold on;

semilogy(x, Original_8x8, 'LineWidth', LineWidth);
hold on;
semilogy(x, QR_8x8, 'LineWidth', LineWidth);
hold on;

semilogy(x, Original_8x16, 'LineWidth', LineWidth);
hold on;
semilogy(x, QR_8x16, 'LineWidth', LineWidth);
hold on;

semilogy(x, Original_16x16, 'LineWidth', LineWidth);
hold on;
semilogy(x, QR_16x16, 'LineWidth', LineWidth);
hold on;


ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('Original 4x4','QR 4x4', 'Original 8x8','QR 8x8', 'Original 16x16','QR 16x16');
title('QR Algorithm');