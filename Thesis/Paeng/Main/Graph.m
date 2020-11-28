clear all;
close all;

x=0:2:20;
LineWidth = 1;
lim_y = 1E-8;

% loading mat file
load(fullfile(pwd, '\result\ISDIC_4x4.mat'));
% ISDIC = length_normalize(x, result);
ISDIC = length_normalize(x, result);

load(fullfile(pwd, '\result\ISDIC_4x4_QR.mat'));
QR_ISDIC = length_normalize(x, result);

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