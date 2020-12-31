clear all;
close all;

x=0:2:20;
LineWidth = 1;
lim_y = 1E-8;

% loading mat file 4x4
antennaCount = '_4x4';

loadName = strcat(pwd, '\result\ISDIC', antennaCount, '.mat');
load(fullfile(loadName));
ISDIC_4x4 = length_normalize(x, result);

loadName = strcat(pwd, '\result\ISDIC', antennaCount, '_QR','.mat');
load(fullfile(loadName));
QR_ISDIC_4x4 = length_normalize(x, result);

% loading mat file 8x8
antennaCount = '_8x8';

loadName = strcat(pwd, '\result\ISDIC', antennaCount, '.mat');
load(fullfile(loadName));
ISDIC_8x8 = length_normalize(x, result);

loadName = strcat(pwd, '\result\ISDIC', antennaCount, '_QR','.mat');
load(fullfile(loadName));
QR_ISDIC_8x8 = length_normalize(x, result);

% loading mat file 16x16
antennaCount = '_16x16';

loadName = strcat(pwd, '\result\ISDIC', antennaCount, '.mat');
load(fullfile(loadName));
ISDIC_16x16 = length_normalize(x, result);

loadName = strcat(pwd, '\result\ISDIC', antennaCount, '_QR','.mat');
load(fullfile(loadName));
QR_ISDIC_16x16 = length_normalize(x, result);

% Draw
f1 = figure;
semilogy(x, ISDIC_4x4, 'LineWidth', LineWidth);
hold on;
semilogy(x, QR_ISDIC_4x4, 'LineWidth', LineWidth);
hold on;
semilogy(x, ISDIC_8x8, 'LineWidth', LineWidth);
hold on;
semilogy(x, QR_ISDIC_8x8, 'LineWidth', LineWidth);
hold on;
semilogy(x, ISDIC_16x16, 'LineWidth', LineWidth);
hold on;
semilogy(x, QR_ISDIC_16x16, 'LineWidth', LineWidth);
hold on;


ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('Origin 4x4','QR 4x4', 'Origin 8x8','QR 8x8', 'Origin 16x16','QR 16x16');
title('QR Algorithm');