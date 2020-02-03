clc;
clear all;
close all;

x=-3:1:12;
graph1 = subplot(2,2,1);
axis([-4 15 0 (10^-5)]);
LineWidth = 3;

% 1) SNR - BER
load('C:\Users\Assistant_2\paeng\Research_assistant\mat_Rayleigh\BPSK_Rayleigh_SNR_BER.mat')
load('C:\Users\Assistant_2\paeng\Research_assistant\mat_Rayleigh\QPSK_Rayleigh_SNR_BER.mat')
load('C:\Users\Assistant_2\paeng\Research_assistant\mat_Rayleigh\QAM_16_Rayleigh_SNR_BER.mat')

Rayleigh_BPSK_SNR_BER = Rayleigh_BPSK_SNR_BER;
Rayleigh_QPSK_SNR_BER = QPSK_Rayleigh_SNR_BER;
Rayleigh_QAM_16_SNR_BER = QAM_16_Rayleigh_SNR_BER;

clearvars QPSK_Rayleigh_SNR_BER QAM_16_BER

semilogy(x,Rayleigh_BPSK_SNR_BER, 'LineWidth', LineWidth);
hold on;
semilogy(x,Rayleigh_QPSK_SNR_BER, 'LineWidth', LineWidth);
hold on;
semilogy(x, Rayleigh_QAM_16_SNR_BER, 'LineWidth', LineWidth);
title('BER - SNR Graph ---->');
ylabel(graph1,'BER ---->');
xlabel(graph1, 'SNR ---->');
legend('BPSK','QPSK','QAM 16');


% 2) SNR - SER
load('C:\Users\Assistant_2\paeng\Research_assistant\mat_Rayleigh\BPSK_Rayleigh_SNR_SER.mat')
load('C:\Users\Assistant_2\paeng\Research_assistant\mat_Rayleigh\QPSK_Rayleigh_SNR_SER.mat')
load('C:\Users\Assistant_2\paeng\Research_assistant\mat_Rayleigh\QAM_16_Rayleigh_SNR_SER.mat')

Rayleigh_BPSK_SNR_BER = Rayleigh_BPSK_SNR_BER;
Rayleigh_QPSK_SNR_SER = QPSK_Rayleigh_SNR_SER;
Rayleigh_QAM_16_SNR_SER = QAM_16_Rayleigh_SNR_SER;

clearvars QPSK_Rayleigh_SNR_SER QAM_16_Rayleigh_SNR_SER

graph2 = subplot(2,2,2);
semilogy(x,Rayleigh_BPSK_SNR_BER, 'LineWidth', LineWidth);
hold on;
semilogy(x,Rayleigh_QPSK_SNR_SER, 'LineWidth', LineWidth);
hold on;
semilogy(x, Rayleigh_QAM_16_SNR_SER, 'LineWidth', LineWidth);
title('SER - SNR Graph ---->');
ylabel(graph2,'SER ---->');
xlabel(graph2, 'SNR ---->');
legend('BPSK','QPSK','QAM 16');

% 3) Eb/N0 - BER
load('C:\Users\Assistant_2\paeng\Research_assistant\mat_Rayleigh\BPSK_Rayleigh_EbN0_BER.mat')
load('C:\Users\Assistant_2\paeng\Research_assistant\mat_Rayleigh\QPSK_Rayleigh_EbN0_BER.mat')
load('C:\Users\Assistant_2\paeng\Research_assistant\mat_Rayleigh\QAM_16_Rayleigh_EbN0_BER.mat')

Rayleigh_BPSK_EbN0_BER = Rayleigh_BPSK_EbN0_BER;
Rayleigh_QPSK_EbN0_BER = QPSK_Rayleigh_EbN0_BER;
Rayleigh_QAM_16_EbN0_BER = QAM_16_Rayleigh_EbN0_BER;

% 변수이름이 같으므로 삭제할 필요 없음
% clearvars BPSK_EbN0_BER QPSK_EbN0_BER
clearvars QPSK_Rayleigh_EbN0_BER QAM_16_Rayleigh_EbN0_BER

graph3 = subplot(2,2,3);
semilogy(x,Rayleigh_BPSK_EbN0_BER, 'LineWidth', LineWidth);
hold on;
semilogy(x,Rayleigh_QPSK_EbN0_BER, 'LineWidth', LineWidth);
hold on;
semilogy(x, Rayleigh_QAM_16_EbN0_BER, 'LineWidth', LineWidth);
title('Eb/N0 - BER Graph ---->');
ylabel(graph3,'SER ---->');
xlabel(graph3, 'SNR ---->');
legend('BPSK','QPSK','QAM 16');


% 4) Eb/N0 - SER
load('C:\Users\Assistant_2\paeng\Research_assistant\mat_Rayleigh\BPSK_Rayleigh_EbN0_SER.mat')
load('C:\Users\Assistant_2\paeng\Research_assistant\mat_Rayleigh\QPSK_Rayleigh_EbN0_SER.mat')
load('C:\Users\Assistant_2\paeng\Research_assistant\mat_Rayleigh\QAM_16_Rayleigh_EbN0_SER.mat')

Rayleigh_BPSK_EbN0_SER = Rayleigh_BPSK_EbN0_SER;
Rayleigh_QPSK_EbN0_SER = QPSK_Rayleigh_EbN0_SER;
Rayleigh_QAM_16_EbN0_SER = QAM_16_Rayleigh_EbN0_SER;


% clearvars BPSK_EbN0_SER QPSK_EbN0_SER
clearvars QPSK_Rayleigh_EbN0_SER QAM_16_Rayleigh_EbN0_SER

graph4 = subplot(2,2,4);
semilogy(x,Rayleigh_BPSK_EbN0_SER, 'LineWidth', LineWidth);
hold on;
semilogy(x,Rayleigh_QPSK_EbN0_SER, 'LineWidth', LineWidth);
hold on;
semilogy(x, Rayleigh_QAM_16_EbN0_SER, 'LineWidth', LineWidth);
title('Eb/N0 - SER Graph ---->');
ylabel(graph4,'SER ---->');
xlabel(graph4, 'SNR ---->');
legend('BPSK','QPSK','QAM 16');
