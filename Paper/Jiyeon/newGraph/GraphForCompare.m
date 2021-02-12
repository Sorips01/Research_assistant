LineWidth = 5;
lim_y = 1E-6;

%% Tx x Rx = 4 x 4
% 
% x = -2:2:16;
% w0 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_1.mat'));
% w1 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_0.5.mat'));
% w2 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_0.6.mat'));
% w3 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_0.7.mat'));
% w4 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_0.8.mat'));
% w5 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_0.9.mat'));
% 
% %
% w0 = reshape(w0.result,5,10);
% w1 = reshape(w1.result,5,10);
% w2 = reshape(w2.result,5,10);
% w3 = reshape(w3.result,5,10);
% w4 = reshape(w4.result,5,10);
% w5 = reshape(w5.result,5,10);

%% Tx x Rx = 8 x 8
%
x = -2:2:8;

w0 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_1.mat'));
w1 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.5.mat'));
w2 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.6.mat'));
w3 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.7.mat'));
w4 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.8.mat'));
w5 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.9.mat'));
w6 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.99.mat'));
%
%
w0 = reshape(w0.result,5,6);
w1 = reshape(w1.result,5,6);
w2 = reshape(w2.result,5,6);
w3 = reshape(w3.result,5,6);
w4 = reshape(w4.result,5,6);
w5 = reshape(w5.result,5,6);
w6 = reshape(w6.result,5,6);
%% Tx x Rx = 16 x 16
% %
% x = -2:2:4;
% 
% % w0 = load(fullfile(pwd, '\matFolder\ISDIC_16x16_Iteration_1.mat'));
% w1 = load(fullfile(pwd, '\matFolder\ISDIC_16x16_Iteration_0.5.mat'));
% w2 = load(fullfile(pwd, '\matFolder\ISDIC_16x16_Iteration_0.6.mat'));
% w3 = load(fullfile(pwd, '\matFolder\ISDIC_16x16_Iteration_0.7.mat'));
% w4 = load(fullfile(pwd, '\matFolder\ISDIC_16x16_Iteration_0.8.mat'));
% w5 = load(fullfile(pwd, '\matFolder\ISDIC_16x16_Iteration_0.9.mat'));
% %
% %
% % w0 = reshape(w0.result,5,4);
% w1 = reshape(w1.result,5,4);
% w2 = reshape(w2.result,5,4);
% w3 = reshape(w3.result,5,4);
% w4 = reshape(w4.result,5,4);
% w5 = reshape(w5.result,5,4);
%% cross-platform


ISDIC_Serial_result_05 = length_normalize(x, w1);
ISDIC_Serial_result_06 = length_normalize(x, w2);
ISDIC_Serial_result_07 = length_normalize(x, w3);
ISDIC_Serial_result_08 = length_normalize(x, w4);
ISDIC_Serial_result_09 = length_normalize(x, w5);
ISDIC_Serial_result_1 = length_normalize(x, w0);
ISDIC_Serial_result_099 = length_normalize(x, w6);

%% iteration
f1 = figure;
semilogy(x,ISDIC_Serial_result_05(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_05(4,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_06(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_06(4,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_07(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_07(4,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_08(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_08(4,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_09(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_09(4,:), 'LineWidth', LineWidth);
hold on;
% semilogy(x,ISDIC_Serial_result_1(1,:), 'LineWidth', LineWidth);
% hold on;


ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('maxP = 0.5 it = 1','maxP = 0.5 it = 4','maxP = 0.6 it = 1','maxP = 0.6 it = 1','maxP = 0.7 it = 1','maxP = 0.7 it = 1','maxP = 0.8 it = 1','maxP = 0.8 it = 4','maxP = 0.9 it = 1' ,'maxP = 0.9 it = 4')
title('iteration = 1');

% % f2 = figure;
% % semilogy(x,ISDIC_Serial_result_05(4,:), 'LineWidth', LineWidth);
% % hold on;
% % semilogy(x,ISDIC_Serial_result_06(4,:), 'LineWidth', LineWidth);
% % hold on;
% % semilogy(x,ISDIC_Serial_result_07(4,:), 'LineWidth', LineWidth);
% % hold on;
% % semilogy(x,ISDIC_Serial_result_08(4,:), 'LineWidth', LineWidth);
% % hold on;
% % semilogy(x,ISDIC_Serial_result_09(4,:), 'LineWidth', LineWidth);
% % hold on;
% % semilogy(x,ISDIC_Serial_result_1(4,:), 'LineWidth', LineWidth);
% % hold on;
% % 
% % ylim([lim_y 1]);
% % ylabel('BER ---->');
% % xlabel('SNR ---->');
% % legend('maxP = 0.5','maxP = 0.6','maxP = 0.7','maxP = 0.8','maxP = 0.9','maxP = 1')
% % title('iteration = 4');
% % %
% 
% 
% %% Threshold  
% % f1 = figure;
% % semilogy(x,ISDIC_Serial_result_05(1,:), 'LineWidth', LineWidth);
% % hold on;
% % semilogy(x,ISDIC_Serial_result_05(4,:), 'LineWidth', LineWidth);
% % hold on;
% 
% % ylim([lim_y 1]);
% % ylabel('BER ---->');
% % xlabel('SNR ---->');
% % legend('iteration = 1','iteration = 4','iteration = 8')
% % title('maxP = 0.5');
% % 
% % f2 = figure;
% % semilogy(x,ISDIC_Serial_result_06(1,:), 'LineWidth', LineWidth);
% % hold on;
% % semilogy(x,ISDIC_Serial_result_06(4,:), 'LineWidth', LineWidth);
% % hold on;
% % 
% % 
% % ylim([lim_y 1]);
% % ylabel('BER ---->');
% % xlabel('SNR ---->');
% % legend('iteration = 1','iteration = 4','iteration = 8')
% % title('maxP = 0.6');
% % %
% % 
% % f3 = figure;
% % semilogy(x,ISDIC_Serial_result_07(1,:), 'LineWidth', LineWidth);
% % hold on;
% % semilogy(x,ISDIC_Serial_result_07(4,:), 'LineWidth', LineWidth);
% % hold on;
% % 
% % ylim([lim_y 1]);
% % ylabel('BER ---->');
% % xlabel('SNR ---->');
% % legend('iteration = 1','iteration = 4','iteration = 8')
% % title('maxP = 0.7');
% % 
% % 
% % f4 = figure;
% % semilogy(x,ISDIC_Serial_result_08(1,:), 'LineWidth', LineWidth);
% % hold on;
% % semilogy(x,ISDIC_Serial_result_08(4,:), 'LineWidth', LineWidth);
% % hold on;
% % 
% % ylim([lim_y 1]);
% % ylabel('BER ---->');
% % xlabel('SNR ---->');
% % legend('iteration = 1','iteration = 4','iteration = 8');
% % title('maxP = 0.8');
% % %
% % % 
% f5 = figure;
% semilogy(x,ISDIC_Serial_result_09(1,:), 'LineWidth', LineWidth);
% hold on;
% semilogy(x,ISDIC_Serial_result_09(4,:), 'LineWidth', LineWidth);
% hold on;
% 
% 
% ylim([lim_y 1]);
% ylabel('BER ---->');
% xlabel('SNR ---->');
% legend('iteration = 1','iteration = 4','iteration = 8');
% title('maxP = 0.9');
% % 
% f1 = figure;
% semilogy(x,ISDIC_Serial_result_1(1,:), 'LineWidth', LineWidth);
% hold on;
% semilogy(x,ISDIC_Serial_result_1(4,:), 'LineWidth', LineWidth);
% hold on;
% 
% ylim([lim_y 1]);
% ylabel('BER ---->');
% xlabel('SNR ---->');
% legend('iteration = 1','iteration = 4','iteration = 8')
% title('maxP = 1');
% 
% f1 = figure;
% semilogy(x,ISDIC_Serial_result_099(1,:), 'LineWidth', LineWidth);
% hold on;
% semilogy(x,ISDIC_Serial_result_099(4,:), 'LineWidth', LineWidth);
% hold on;
% 
% ylim([lim_y 1]);
% ylabel('BER ---->');
% xlabel('SNR ---->');
% legend('iteration = 1','iteration = 4','iteration = 8')
% title('maxP = 0.99');
% 
