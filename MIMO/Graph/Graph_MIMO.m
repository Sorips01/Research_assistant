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
LineWidth = 1;
lim_y = 1E-8;

% loading mat file
load(fullfile(pwd, '\mat_folder\QPSK_new_meta_ML.mat'));
load(fullfile(pwd, '\mat_folder\QPSK_new_meta_MMSE.mat'));
load(fullfile(pwd, '\mat_folder\QPSK_new_meta_ZF.mat'));

load(fullfile(pwd, '\mat_folder\QPSK_new_meta_ZF_SIC.mat'));
load(fullfile(pwd, '\mat_folder\QPSK_new_meta_MMSE_SIC.mat'));

load(fullfile(pwd, '\mat_folder\QPSK_new_meta_OSIC_ZF.mat'));
load(fullfile(pwd, '\mat_folder\QPSK_new_meta_OSIC.mat'));

% length of result normalize
ZF_result_2x2 = length_normalize(x, ZF_result_2x2);
ZF_result_4x4 = length_normalize(x, ZF_result_4x4);
MMSE_result2x2 = length_normalize(x, MMSE_result2x2);
MMSE_result4x4 = length_normalize(x, MMSE_result4x4);
ML_result_2x2 = length_normalize(x, ML_result_2x2);
ML_result_4x4 = length_normalize(x, ML_result_4x4);

ZF_SIC_result_2x2 = length_normalize(x, ZF_SIC_result_2x2);
ZF_SIC_result_4x4 = length_normalize(x, ZF_SIC_result_4x4);
MMSE_SIC_result_2x2 = length_normalize(x, MMSE_SIC_result_2x2);
MMSE_SIC_result_4x4 = length_normalize(x, MMSE_SIC_result_4x4);

% MMSE-OSIC
MMSE_OSIC_result_2x2 = length_normalize(x, MMSE_OSIC_result_2x2); 
MMSE_OSIC_result_4x4 = length_normalize(x, MMSE_OSIC_result_4x4);

OSIC_ZF_result_2x2 = length_normalize(x, OSIC_ZF_result_2x2); 
OSIC_ZF_result_4x4 = length_normalize(x, OSIC_ZF_result_4x4);


% ZF / MMSE / ML : 2x2
f1 = figure;
semilogy(x, ZF_result_2x2, 'LineWidth', LineWidth);
hold on;
semilogy(x, MMSE_result2x2, 'LineWidth', LineWidth);
hold on;
semilogy(x, ML_result_2x2, 'LineWidth', LineWidth);
hold on;

% ZF-SIC / MMSE-SIC 2x2
semilogy(x, ZF_SIC_result_2x2, 'LineWidth', LineWidth);
hold on;
semilogy(x, MMSE_SIC_result_2x2, 'LineWidth', LineWidth);
hold on;

% ZF-OSIC / MMSE-OSIC 2x2
semilogy(x, ZF_SIC_result_2x2, 'LineWidth', LineWidth);
hold on;
semilogy(x, MMSE_OSIC_result_2x2, 'LineWidth', LineWidth);
hold on;

% xlim([0 60]);
ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('ZF','MMSE','ML','ZF-SIC','MMSE-SIC','ZF-OSIC','MMSE-OSIC');
title('MIMO 2x2');

% ZF / MMSE / ML : 4x4
f2 = figure;
semilogy(x, ZF_result_4x4, 'LineWidth', LineWidth);
hold on;
semilogy(x, MMSE_result4x4, 'LineWidth', LineWidth);
hold on;
semilogy(x, ML_result_4x4, 'LineWidth', LineWidth);
hold on;

% ZF-SIC / MMSE-SIC 4x4
semilogy(x, ZF_SIC_result_4x4, 'LineWidth', LineWidth);
hold on;
semilogy(x, MMSE_SIC_result_4x4, 'LineWidth', LineWidth);
hold on;

% ZF-OSIC / MMSE-OSIC 4x4
semilogy(x, OSIC_ZF_result_4x4, 'LineWidth', LineWidth);
hold on;
semilogy(x, MMSE_OSIC_result_4x4, 'LineWidth', LineWidth);
hold on;

ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('ZF','MMSE','ML','ZF-SIC','MMSE-SIC','ZF-OSIC','MMSE-OSIC');
title('MIMO 4x4');