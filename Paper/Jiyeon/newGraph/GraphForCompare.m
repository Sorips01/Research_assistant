
LineWidth = 5;
lim_y = 1E-6;

%% Tx x Rx = 4 x 4
%
% w1 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_0.5.mat'));
% w2 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_0.6.mat'));
% w3 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_0.7.mat'));
% w4 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_0.8.mat'));
% w5 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_0.9.mat'));


%% Tx x Rx = 8 x 8
% %
x = 0:2:10;
x2 = 0:2:8;

w1 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.5.mat'));
w2 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.6.mat'));
w3 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.7.mat'));
w4 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.8.mat'));
w5 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.9.mat'));
%
%
w1 = reshape(w1.result,5,6);
w2 = reshape(w2.result,5,6);
w3 = reshape(w3.result,5,6);
w4 = reshape(w4.result,5,5);
w5 = reshape(w5.result,5,5);

%% cross-platform


ISDIC_Serial_result_05 = length_normalize(x, w1);
ISDIC_Serial_result_06 = length_normalize(x, w2);
ISDIC_Serial_result_07 = length_normalize(x, w3);
ISDIC_Serial_result_08 = length_normalize(x2, w4);
ISDIC_Serial_result_09 = length_normalize(x2, w5);

f1 = figure;
semilogy(x,ISDIC_Serial_result_05(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_05(4,:), 'LineWidth', LineWidth);
hold on;

f2 = figure;
semilogy(x,ISDIC_Serial_result_06(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_06(4,:), 'LineWidth', LineWidth);
hold on;




ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('iteration = 1','iteration = 4','iteration = 8')
title('maxP = 0.6');
%

f3 = figure;
semilogy(x,ISDIC_Serial_result_07(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_07(4,:), 'LineWidth', LineWidth);
hold on;


ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('iteration = 1','iteration = 4','iteration = 8')
title('maxP = 0.7');

f4 = figure;
semilogy(x2,ISDIC_Serial_result_08(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x2,ISDIC_Serial_result_08(4,:), 'LineWidth', LineWidth);
hold on;




ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('iteration = 1','iteration = 4','iteration = 8');
title('maxP = 0.8');
%

f5 = figure;
semilogy(x2,ISDIC_Serial_result_09(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x2,ISDIC_Serial_result_09(4,:), 'LineWidth', LineWidth);
hold on;


ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('iteration = 1','iteration = 4','iteration = 8');
title('maxP = 0.9');



