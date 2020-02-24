% clc;
clear all;
close all;



run('MRT_Rayleigh_fading_Channel_QPSK.m');
run('Selection_Rayleigh_fading_Channel_QPSK.m');
run('Alamouti_was_awesome_in_QPSK.m');
clear all;


x=0:5:60;
LineWidth = 2;

cd ..
load(fullfile(pwd, '\mat_Rayleigh_fading_MISO\QPSK_Rayleigh_MISO.mat'));
cd Rayleigh_fading_MISO

lim_y = 1E-6;

% 1) SNR - BER (RX is 2)
graph1 = subplot(3,1,1);
semilogy(x,QPSK_BER_MRC_RX_2, 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_EGC_RX_2, 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_SC_RX_2, 'LineWidth', LineWidth);
hold on;
xlim([0 60]);
ylim([lim_y 1]);
title('RX is 2 & MRC / EGC / SC ---->');
ylabel(graph1,'BER ---->');
xlabel(graph1, 'SNR ---->');
legend('MRC','EGC','SC');
% legend('EGC','SC');

% 2) SNR - BER (RX is 3)
graph2 = subplot(3,1,2);
semilogy(x,QPSK_BER_MRC_RX_3, 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_EGC_RX_3, 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_SC_RX_3, 'LineWidth', LineWidth);
hold on;
xlim([0 60]);
ylim([lim_y 1]);
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
xlim([0 60]);
ylim([lim_y 1]);
title('RX is 4 & MRC / EGC / SC ---->');
ylabel(graph3,'BER ---->');
xlabel(graph3, 'SNR ---->');
legend('MRC','EGC','SC');



