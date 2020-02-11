% clc;
clearvars;
close all;

%run('Rayleigh_fading_Channel_QPSK.m');

x=0:5:60;
LineWidth = 3;

load(fullfile(pwd, '\mat_Rayleigh_fading_SIMO\QPSK_Rayleigh_SIMO.mat'));


% 1) SNR - BER (RX is 2)
graph1 = subplot(3,1,1);
semilogy(x,QPSK_BER_MRC(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_EGC(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_SC(1,:), 'LineWidth', LineWidth);
hold on;
title('RX is 2 & MRC / EGC / SC ---->');
ylabel(graph1,'BER ---->');
xlabel(graph1, 'SNR ---->');
legend('MRC','EGC','SC');

% 2) SNR - BER (RX is 3)
graph2 = subplot(3,1,2);
semilogy(x,QPSK_BER_MRC(2,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_EGC(2,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_SC(2,:), 'LineWidth', LineWidth);
hold on;
title('RX is 3 & MRC / EGC / SC ---->');
ylabel(graph2,'BER ---->');
xlabel(graph2, 'SNR ---->');
legend('MRC','EGC','SC');


% 3) SNR - BER (RX is 4)
graph3 = subplot(3,1,3);
semilogy(x,QPSK_BER_MRC(3,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_EGC(3,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_SC(3,:), 'LineWidth', LineWidth);
hold on;
title('RX is 4 & MRC / EGC / SC ---->');
ylabel(graph3,'BER ---->');
xlabel(graph3, 'SNR ---->');
legend('MRC','EGC','SC');



