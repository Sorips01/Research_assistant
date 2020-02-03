clc;
clear all;
close all;

x=-3:1:12;
graph1 = subplot(2,2,1);
axis([-4 15 0 (10^-5)]);
LineWidth = 3;

% 1) SNR - BER
load(fullfile(pwd,'\mat_SNR\BPSK_SNR_BER.mat'));
load(fullfile(pwd,'\mat_SNR\QPSK_SNR_BER.mat'));
load(fullfile(pwd,'\mat_SNR\QAM_16_SNR_BER.mat'));

BPSK_SNR_BER = BPSK_BER;
QPSK_SNR_BER = QPSK_BER;
QAM_16_SNR_BER = QAM_16_BER;

clearvars BPSK_BER QPSK_BER QAM_16_BER

semilogy(x,BPSK_SNR_BER, 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_SNR_BER, 'LineWidth', LineWidth);
hold on;
semilogy(x, QAM_16_SNR_BER, 'LineWidth', LineWidth);
title('BER - SNR Graph ---->');
ylabel(graph1,'BER ---->');
xlabel(graph1, 'SNR ---->');
legend('BPSK','QPSK','QAM 16');


% 2) SNR - SER
load(fullfile(pwd,'\mat_SNR\BPSK_SNR_SER.mat'));
load(fullfile(pwd,'\mat_SNR\QPSK_SNR_SER.mat'));
load(fullfile(pwd,'\mat_SNR\QAM_16_SNR_SER.mat'));

BPSK_SNR_SER = BPSK_SER;
QPSK_SNR_SER = QPSK_SER;
QAM_16_SNR_SER = QAM_16_SER;

clearvars BPSK_SER QPSK_SER QAM_16_SER

graph2 = subplot(2,2,2);
semilogy(x,BPSK_SNR_SER, 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_SNR_SER, 'LineWidth', LineWidth);
hold on;
semilogy(x, QAM_16_SNR_SER, 'LineWidth', LineWidth);
title('SER - SNR Graph ---->');
ylabel(graph2,'SER ---->');
xlabel(graph2, 'SNR ---->');
legend('BPSK','QPSK','QAM 16');

% 3) Eb/N0 - BER
load(fullfile(pwd,'\mat_EbN0\BPSK_EbN0_BER.mat'));
load(fullfile(pwd,'\mat_EbN0\QPSK_EbN0_BER.mat'));
load(fullfile(pwd,'\mat_EbN0\QAM_16_EbN0_BER.mat'));

BPSK_EbN0_BER = BPSK_EbN0_BER;
QPSK_EbN0_BER = QPSK_EbN0_BER;
QAM_16_EbN0_BER = QAM_16_BER;

% 변수이름이 같으므로 삭제할 필요 없음
% clearvars BPSK_EbN0_BER QPSK_EbN0_BER
clearvars QAM_16_BER

graph3 = subplot(2,2,3);
semilogy(x,BPSK_EbN0_BER, 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_EbN0_BER, 'LineWidth', LineWidth);
hold on;
semilogy(x, QAM_16_EbN0_BER, 'LineWidth', LineWidth);
title('Eb/N0 - BER Graph ---->');
ylabel(graph3,'SER ---->');
xlabel(graph3, 'SNR ---->');
legend('BPSK','QPSK','QAM 16');


% 4) Eb/N0 - SER
load(fullfile(pwd,'\mat_EbN0\BPSK_EbN0_SER.mat'));
load(fullfile(pwd,'\mat_EbN0\QAM_16_EbN0_SER.mat'));
load(fullfile(pwd,'\mat_EbN0\QPSK_EbN0_SER.mat'));

BPSK_EbN0_SER = BPSK_EbN0_SER;
QPSK_EbN0_SER = QPSK_EbN0_SER;
QAM_16_EbN0_SER = QAM_16_SER;


% clearvars BPSK_EbN0_SER QPSK_EbN0_SER
clearvars QAM_16_BER

graph4 = subplot(2,2,4);
semilogy(x,BPSK_EbN0_SER, 'LineWidth', LineWidth);
hold on;
semilogy(x,QPSK_EbN0_SER, 'LineWidth', LineWidth);
hold on;
semilogy(x, QAM_16_EbN0_SER, 'LineWidth', LineWidth);
title('Eb/N0 - SER Graph ---->');
ylabel(graph4,'SER ---->');
xlabel(graph4, 'SNR ---->');
legend('BPSK','QPSK','QAM 16');
