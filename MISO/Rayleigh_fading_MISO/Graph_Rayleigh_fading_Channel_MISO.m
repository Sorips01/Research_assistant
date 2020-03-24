% clc;
clear all;
close all;

run('MRT_Rayleigh_fading_Channel_QPSK.m');
% run('Selection_Rayleigh_fading_Channel_QPSK.m');
% run('Alamouti_was_awesome_in_QPSK.m');
clear all;


x=0:5:60;
LineWidth = 3;

cd ..
load(fullfile(pwd, '\mat_Rayleigh_fading_MISO\QPSK_Rayleigh_MISO.mat'));
load(fullfile(pwd, '\mat_Rayleigh_fading_MISO\MRT_QPSK_Rayleigh_MISO.mat'));
load(fullfile(pwd, '\mat_Rayleigh_fading_MISO\Selection_QPSK_Rayleigh_MISO.mat'));
load(fullfile(pwd, '\mat_Rayleigh_fading_MISO\test.mat'));
cd Rayleigh_fading_MISO
Alamouti_QPSK_BER = [Alamouti_QPSK_BER 0 0 0 0 0 0];
lim_y = 1E-6;

f1 = figure;
% 1) SNR - BER (RX is 2)
graph1 = subplot(3,1,1);
semilogy(x,QPSK_BER_MRT(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_Selection(1,:), 'LineWidth', LineWidth);
hold on;
xlim([0 35]);
ylim([lim_y 1]);
title('Tx is 2 & MRT / Selection ---->');
ylabel(graph1,'BER ---->');
xlabel(graph1, 'SNR ---->');
legend('MRT','Selection');
% legend('EGC','SC');

% 2) SNR - BER (RX is 3)
graph2 = subplot(3,1,2);
semilogy(x,QPSK_BER_MRT(2,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_Selection(2,:), 'LineWidth', LineWidth);
hold on;
xlim([0 35]);
ylim([lim_y 1]);
title('Tx is 3 & MRT / Selection ---->');
ylabel(graph2,'BER ---->');
xlabel(graph2, 'SNR ---->');
legend('MRT','Selection');


% 3) SNR - BER (RX is 4)
graph3 = subplot(3,1,3);
semilogy(x,QPSK_BER_MRT(3,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_BER_Selection(3,:), 'LineWidth', LineWidth);
hold on;
xlim([0 35]);
ylim([lim_y 1]);
title('Tx is 4 & MRT / Selection ---->');
ylabel(graph3,'BER ---->');
xlabel(graph3, 'SNR ---->');
legend('MRT','Selection');

f2 = figure;
semilogy(x,Alamouti_QPSK_BER, 'LineWidth', LineWidth);
xlim([0 35]);
ylim([lim_y 1]);
title('Tx is 2 & Alamouti ---->');
ylabel('BER ---->');
xlabel('SNR ---->');
legend('Alamouti');


