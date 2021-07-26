clear all;
close all;

x=-14:2:14;
LineWidth = 1;
lim_y = 1E-5;

% antennaCount = ["_4x4","_4x8" ,"_8x8", "_8x16","_16x16" ];
antennaCount = ["_4x4" ];

% loading mat file 4x4

loadName = strcat(pwd, '\result\ISDIC', antennaCount(1), '_QR.mat');
load(fullfile(loadName));
Original_4x4_iter_1 = length_normalize(x, result(:,1)');
Original_4x4_iter_5 = length_normalize(x, result(:,5)');
loadName = strcat(pwd, '\result\ISDIC', antennaCount(1), '_QR_LC','.mat');
load(fullfile(loadName));
Proposed_4x4_iter_1 = length_normalize(x, result(:,1)');
Proposed_4x4_iter_5 = length_normalize(x, result(:,5)');

% Draw
f1 = figure;

%% iteration 1

semilogy(x, Original_4x4_iter_1, 'LineWidth', LineWidth);
hold on;
semilogy(x, Proposed_4x4_iter_1, 'LineWidth', LineWidth);
hold on;

%% iteration 5

semilogy(x, Original_4x4_iter_5, 'LineWidth', LineWidth);
hold on;
semilogy(x, Proposed_4x4_iter_5, 'LineWidth', LineWidth);
hold on;


xlim([-14 14]);
ylim([lim_y 1]);
ylabel('Average BER');
xlabel('SNR');
legend('Original 3x3 Iter:1','Proposed 3x3 Iter:1', 'Original 3x3 Iter:5','Proposed 3x3 Iter:5');
title('QR Proposed Low Complexity');