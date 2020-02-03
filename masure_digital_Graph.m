clc;
clear all;
close all;

% 1) BER-SNR 
%load ('BPSK_SNR_BER.mat','BPSK_BER');
load('C:\Users\Assistant_3\Documents\GitHub\Research_assistant\mat_SNR\BPSK_SNR_BER.mat')
x=-3:1:15;
graph1 = subplot(2,2,1);

semilogy(x,BPSK_BER);
load ('QPSK_BER_measure_digital.mat','QPSK_BER');
hold on;
semilogy(x,QPSK_BER);
hold on;
semilogy(x, QAM_16_BER);
title('BER-SNR Graph ---->');
ylabel(graph1,'BER ---->');
xlabel(graph1, 'SNR ---->');
legend('BPSK','QPSK','QAM 16');

% 2) SER-SNR 
load('BPSK_SNR_SER.mat','BPSK_SER');
x=0:1:10;
graph2 = subplot(2,2,2);
semilogy(x,BPSK_SER);
load ('QPSK_SER_measure_digital.mat','QPSK_SER');
hold on;
semilogy(x,QPSK_SER);
hold on;
semilogy(x, QAM_16_SER);
title('SER-SNR Graph ---->');
ylabel(graph2,'SER ---->');
xlabel(graph2, 'SNR ---->');
legend('BPSK','QPSK','QAM 16');

% 3) 


