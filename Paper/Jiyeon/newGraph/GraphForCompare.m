LineWidth = 2;
lim_y = 1E-4;

%%  load matfile
x = -2:2:8;

it = 1:1:5;

wo = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_1.5.mat'));
w1 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.5.mat'));
% w2 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.6.mat'));
w3 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.7.mat'));
% w4 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.8.mat'));
w5 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.9.mat'));

%% reshape

result0 = reshape(wo.result,5,6);
result1 = reshape(w1.result,5,6);
% result2 = reshape(w2.result,5,6);
result3 = reshape(w3.result,5,6);
% result4 = reshape(w4.result,5,6);
result5 = reshape(w5.result,5,6);

cal0 = reshape(wo.cal,5,6);
cal1 = reshape(w1.cal,5,6);
% cal2 = reshape(w2.cal,5,6);
cal3 = reshape(w3.cal,5,6);
% cal4 = reshape(w4.cal,5,6);
cal5 = reshape(w5.cal,5,6);


%% length normalize

ISDIC_Serial_result_conventional = length_normalize(x, result0);
ISDIC_Serial_result_05 = length_normalize(x, result1);
% ISDIC_Serial_result_06 = length_normalize(x, result2);
ISDIC_Serial_result_07 = length_normalize(x, result3);
% ISDIC_Serial_result_08 = length_normalize(x, result4);
ISDIC_Serial_result_09 = length_normalize(x, result5);


%% maxP = 0.5~09 iteration = 1/ iteration = 4

f1 = figure;
semilogy(x,ISDIC_Serial_result_conventional(4,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_05(4,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_07(4,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_09(4,:), 'LineWidth', LineWidth);
hold on;

ylim([lim_y 1]);
ylabel('BER ');
xlabel('SNR[dB]');
legend('conventional','maxP = 0.5 it = 4','maxP = 0.7 it = 4' ,'maxP = 0.9 it = 4');

%% calculation
f2 = figure;
semilogy(it,cal0(:,1), 'LineWidth', LineWidth);
hold on;
semilogy(it,cal1(:,1), 'LineWidth', LineWidth);
hold on;
semilogy(it,cal3(:,1), 'LineWidth', LineWidth);
hold on;
semilogy(it,cal5(:,1), 'LineWidth', LineWidth);
hold on;


% ylim([lim_y 1]);
ylabel('calculation');
xlabel('Iteration');
legend('maxP = 0.5','maxP = 0.7','maxP = 0.9');
