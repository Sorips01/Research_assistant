clear all;
close all;

% cd ZF
% run('QPSK_new_meta_ZF.m');
% cd ..
% cd MMSE
% run('QPSK_new_meta_MMSE.m');
% cd ..
% clear all;

x=0:5:60;
LineWidth = 3;
lim_y = 1E-8;

% loading mat file
load(fullfile(pwd, '\mat_folder\QPSK_new_meta_ML.mat'));
load(fullfile(pwd, '\mat_folder\QPSK_new_meta_OSIC.mat'));

% length of result normalize
%ZF_result = length_normalize(x, ZF_result);
%MMSE_result = length_normalize(x, MMSE_result);

% ZF / MMSE / ML : 2x2
f1 = figure;
semilogy(x, ZF_result, 'LineWidth', LineWidth);
hold on;
semilogy(x, MMSE_result, 'LineWidth', LineWidth);
hold on;
semilogy(x, ML_result, 'LineWidth', LineWidth);
hold on;

% ZF-SIC / MMSE-SIC 2x2
semilogy(x, ZF_result, 'LineWidth', LineWidth);
hold on;
semilogy(x, MMSE_result, 'LineWidth', LineWidth);
hold on;

% ZF-OSIC / MMSE-OSIC 2x2
semilogy(x, ZF_result, 'LineWidth', LineWidth);
hold on;
semilogy(x, MMSE_result, 'LineWidth', LineWidth);
hold on;

% xlim([0 60]);
ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('ZF','MMSE','ML');

% ZF / MMSE / ML : 4x4
f2 = figure;
semilogy(x, ZF_result, 'LineWidth', LineWidth);
hold on;
semilogy(x, MMSE_result, 'LineWidth', LineWidth);
hold on;

% xlim([0 60]);
ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('ZF','MMSE','ML');

% ZF-SIC / MMSE-SIC 4x4
semilogy(x, ZF_result, 'LineWidth', LineWidth);
hold on;
semilogy(x, MMSE_result, 'LineWidth', LineWidth);
hold on;

% ZF-OSIC / MMSE-OSIC 4x4
semilogy(x, ZF_result, 'LineWidth', LineWidth);
hold on;
semilogy(x, MMSE_result, 'LineWidth', LineWidth);
hold on;

