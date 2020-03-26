% clc;
clear all;
close all;

run('QPSK_new_meta_ZF.m');
run('QPSK_new_meta_MMSE.m');
clear all;

x=0:5:60;
LineWidth = 3;
lim_y = 1E-8;

cd ZF
load(fullfile(pwd, '\mat_folder\QPSK_new_meta_ZF.mat'));
cd ..
cd MMSE
load(fullfile(pwd, '\mat_folder\QPSK_new_meta_MMSE.mat'));
cd ..
load(fullfile(pwd, '\RX_3_MRC_QPSK_Rayleigh_SIMO'));

% ZF / MMSE / MRC
f1 = figure;
semilogy(x,ZF_result, 'LineWidth', LineWidth);
hold on;
semilogy(x,MMSE_result, 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_MRC_RX_3, 'LineWidth', LineWidth);
hold on;
xlim([0 60]);
ylim([lim_y 1]);
ylabel(graph1,'BER ---->');
xlabel(graph1, 'SNR ---->');
legend('ZF','MMSE','MRC');

