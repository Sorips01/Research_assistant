% clc;
clearvars;
close all;

for a = 2:1:4  
    %run(sprintf('RX_%d_MRC_Rayleigh_fading_Channel_QPSK.m',a));
    %run(sprintf('RX_%d_EGC_Rayleigh_fading_Channel_QPSK.m',a));
    %run(sprintf('RX_%d_SC_Rayleigh_fading_Channel_QPSK.m',a));
end
clearvars;

x=0:5:60;
LineWidth = 3;

cd ..
load(fullfile(pwd, '\mat_Rayleigh_fading_SIMO\RX_4_MRC_QPSK_Rayleigh_SIMO.mat'));
load(fullfile(pwd, '\mat_Rayleigh_fading_SIMO\RX_4_EGC_QPSK_Rayleigh_SIMO.mat'));
load(fullfile(pwd, '\mat_Rayleigh_fading_SIMO\RX_4_SC_QPSK_Rayleigh_SIMO.mat'));

load(fullfile(pwd, '\mat_Rayleigh_fading_SIMO\RX_3_MRC_QPSK_Rayleigh_SIMO.mat'));
load(fullfile(pwd, '\mat_Rayleigh_fading_SIMO\RX_3_EGC_QPSK_Rayleigh_SIMO.mat'));
load(fullfile(pwd, '\mat_Rayleigh_fading_SIMO\RX_3_SC_QPSK_Rayleigh_SIMO.mat'));

load(fullfile(pwd, '\mat_Rayleigh_fading_SIMO\RX_2_MRC_QPSK_Rayleigh_SIMO.mat'));
load(fullfile(pwd, '\mat_Rayleigh_fading_SIMO\RX_2_EGC_QPSK_Rayleigh_SIMO.mat'));
load(fullfile(pwd, '\mat_Rayleigh_fading_SIMO\RX_2_SC_QPSK_Rayleigh_SIMO.mat'));


% 1) SNR - BER (RX is 2)
graph1 = subplot(3,1,1);
semilogy(x,QPSK_BER_MRC_RX_2, 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_EGC_RX_2, 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_SC_RX_2, 'LineWidth', LineWidth);
hold on;
title('RX is 2 & MRC / EGC / SC ---->');
ylabel(graph1,'BER ---->');
xlabel(graph1, 'SNR ---->');
legend('MRC','EGC','SC');

% 2) SNR - BER (RX is 3)
graph2 = subplot(3,1,2);
semilogy(x,QPSK_BER_MRC_RX_3, 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_EGC_RX_3, 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_SC_RX_3, 'LineWidth', LineWidth);
hold on;
title('RX is 3 & MRC / EGC / SC ---->');
ylabel(graph2,'BER ---->');
xlabel(graph2, 'SNR ---->');
legend('MRC','EGC','SC');


% 3) SNR - BER (RX is 4)
graph3 = subplot(3,1,3);
semilogy(x,QPSK_BER_MRC_RX_4, 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_EGC_RX_4, 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_SC_RX_4, 'LineWidth', LineWidth);
hold on;
title('RX is 4 & MRC / EGC / SC ---->');
ylabel(graph3,'BER ---->');
xlabel(graph3, 'SNR ---->');
legend('MRC','EGC','SC');



