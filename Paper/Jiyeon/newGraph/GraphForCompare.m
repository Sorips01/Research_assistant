x=0:2:16;
LineWidth = 1.5;
lim_y = 1E-6;

w1 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_0.5.mat'));
w2 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_0.6.mat'));
w3 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_0.7.mat'));
w4 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_0.8.mat'));
w5 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_0.9.mat'));


w1 = reshape(w1.result,8,9);
w2 = reshape(w2.result,8,9);
w3 = reshape(w3.result,8,9);
w4 = reshape(w4.result,8,9);
w5 = reshape(w5.result,8,9);


ISDIC_Serial_result_05 = length_normalize(x, w1);
ISDIC_Serial_result_06 = length_normalize(x, w2);
ISDIC_Serial_result_07 = length_normalize(x, w3);
ISDIC_Serial_result_08 = length_normalize(x, w4);
ISDIC_Serial_result_09 = length_normalize(x, w5);


f1 = figure;
semilogy(x,ISDIC_Serial_result_05(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_06(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_07(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_08(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_09(1,:), 'LineWidth', LineWidth);
hold on;



ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('maxP = 0.5','maxP = 0.6','maxP = 0.7','maxP = 0.8','maxP = 0.9');
title('iteration = 1');


% f4 = figure;
% semilogy(x,ISDIC_Serial_result_05(4,:), 'LineWidth', LineWidth);
% hold on;
% semilogy(x,ISDIC_Serial_result_06(4,:), 'LineWidth', LineWidth);
% hold on;
% semilogy(x,ISDIC_Serial_result_07(4,:), 'LineWidth', LineWidth);
% hold on;
% semilogy(x,ISDIC_Serial_result_08(4,:), 'LineWidth', LineWidth);
% hold on;
% semilogy(x,ISDIC_Serial_result_09(4,:), 'LineWidth', LineWidth);
% hold on;
% 
% 
% 
% ylim([lim_y 1]);
% ylabel('BER ---->');
% xlabel('SNR ---->');
% legend('maxP = 0.5','maxP = 0.6','maxP = 0.7','maxP = 0.8','maxP = 0.9');
% title('iteration = 4');

f8 = figure;
semilogy(x,ISDIC_Serial_result_05(8,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_06(8,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_07(8,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_08(8,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_09(8,:), 'LineWidth', LineWidth);
hold on;

ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('maxP = 0.5','maxP = 0.6','maxP = 0.7','maxP = 0.8','maxP = 0.9');
title('iteration = 8');

