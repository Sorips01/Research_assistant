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
cd ZF
load(fullfile(pwd, '\mat_folder\QPSK_new_meta_ZF.mat'));
cd ..
cd MMSE
load(fullfile(pwd, '\mat_folder\QPSK_new_meta_MMSE.mat'));
cd ..
load(fullfile(pwd, '\RX_3_MRC_QPSK_Rayleigh_SIMO'));

% length of result normalize
ZF_result = length_normalize(x, ZF_result);
MMSE_result = length_normalize(x, MMSE_result);

% ZF / MMSE / MRC
f1 = figure;
semilogy(x,ZF_result, 'LineWidth', LineWidth);
hold on;
semilogy(x,MMSE_result, 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_MRC_RX_3, 'LineWidth', LineWidth);
hold on;
% xlim([0 60]);
ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('ZF','MMSE','MRC');

