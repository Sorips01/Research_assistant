% cd MMSE
% run('QPSK_new_meta_MMSE.m');
% cd ..
% clear all;

x=0:2:20;
LineWidth = 1;
lim_y = 1E-8;

% loading mat file
% load(fullfile(pwd, '\mat_folder\QPSK_new_meta_MMSE_ISDIC_Serial_3x3.mat'));
load(fullfile(pwd, '\mat_folder\QPSK_new_meta_MMSE_ISDIC_Serial_8x8.mat'));

% length of result normalize
% ISDIC_Serial_result_1 = length_normalize(x, ISDIC_Serial_result_1);
ISDIC_Serial_result_maxP = length_normalize(x, QPSK_new_meta_MMSE_ISDIC_Serial_result_maxP);
% ISDIC_Serial_result_absOfSubstraction = length_normalize(x, ISDIC_Serial_result_absOfSubstraction);

% % ISDIC 3x3
% f1 = figure;
% semilogy(x,ISDIC_Serial_result_maxP, 'LineWidth', LineWidth);
% hold on;
% % semilogy(x,ISDIC_Serial_result_absOfSubstraction, 'LineWidth', LineWidth);
% % hold on;

% ISDIC 8x8
f1 = figure;
semilogy(x,ISDIC_Serial_result_maxP, 'LineWidth', LineWidth);
hold on;
% semilogy(x,ISDIC_Serial_result_absOfSubstraction, 'LineWidth', LineWidth);
% hold on;


% xlim([0 60]);
ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('maxP','absOfSubstraction');
title('ISDIC Serial');
