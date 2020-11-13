clear all;
close all;

x=0:5:60;
LineWidth = 1;
lim_y = 1E-8;

% loading mat file
load(fullfile(pwd, '\result\ISDIC_8x8_original.mat'));
% ISDIC = length_normalize(x, result);
ISDIC = length_normalize(x, QPSK_new_meta_MMSE_ISDIC_Parallel_result_8x8);

load(fullfile(pwd, '\result\ISDIC_8x8_QR.mat'));
QR_ISDIC = length_normalize(x, QPSK_new_meta_MMSE_ISDIC_Parallel_result_8x8);

% ZF / MMSE / ML : 2x2
f1 = figure;
semilogy(x, ISDIC, 'LineWidth', LineWidth);
hold on;
semilogy(x, QR_ISDIC, 'LineWidth', LineWidth);
hold on;

% xlim([0 60]);
ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('Origin','QR');
title('QR Algorithm');