LineWidth = 2;
lim_y = 1E-4;

%%  load matfile
x = 0:2:8;

it = 1:1:5;

wo = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_1.5.mat'));
%8x8
w1 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.5.mat'));
w2 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.7.mat'));
w3 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.9.mat'));
%16x16
w4 = load(fullfile(pwd, '\matFolder\ISDIC_16x16_Iteration_0.5.mat'));
w5 = load(fullfile(pwd, '\matFolder\ISDIC_16x16_Iteration_0.7.mat'));
w6 = load(fullfile(pwd, '\matFolder\ISDIC_16x16_Iteration_0.9.mat'));
%% reshape

result0 = reshape(wo.result,5,6);
%8x8
result1 = reshape(w1.result,5,6);
result2 = reshape(w2.result,5,6);
result3 = reshape(w3.result,5,6);
%16x16
result4 = reshape(w4.result,5,4);
result5 = reshape(w5.result,5,4);
result6 = reshape(w6.result,5,4);

cal0 = reshape(wo.cal,5,6);
%8x8
cal1 = reshape(w1.cal,5,6);
cal2 = reshape(w2.cal,5,6);
cal3 = reshape(w3.cal,5,6);
%16x16
cal4 = reshape(w4.cal,5,4);
cal5 = reshape(w5.cal,5,4);
cal6 = reshape(w6.cal,5,4);


%% length normalize

ISDIC_Serial_result_conventional = length_normalize(x, result0);
%8x8
ISDIC_Serial_result_805 = length_normalize(x, result1);
ISDIC_Serial_result_807 = length_normalize(x, result2);
ISDIC_Serial_result_809 = length_normalize(x, result3);
%16x16
ISDIC_Serial_result_1605 = length_normalize(x, result4);
ISDIC_Serial_result_1607 = length_normalize(x, result5);
ISDIC_Serial_result_1609 = length_normalize(x, result6);

%% maxP = 0.5~09 iteration = 1/ iteration = 4

f1 = figure;
semilogy(x,ISDIC_Serial_result_conventional(4,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_805(4,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_807(4,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_809(4,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_1605(4,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_1607(4,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_1609(4,:), 'LineWidth', LineWidth);
hold on;

ylim([lim_y 1]);
ylabel('BER ');
xlabel('SNR[dB]');
legend('conventional','p* = 0.5','p* = 0.7' ,'p* = 0.9');

%% calculation
f2 = figure;
semilogy(it,cal0(:,1), 'LineWidth', LineWidth);
hold on;
semilogy(it,cal1(:,1), 'LineWidth', LineWidth);
hold on;
semilogy(it,cal2(:,1), 'LineWidth', LineWidth);
hold on;
semilogy(it,cal3(:,1), 'LineWidth', LineWidth);
hold on;


% ylim([lim_y 1]);
ylabel('calculation');
xlabel('Iteration');
legend('conventional','P* = 0.5','p* = 0.7','p* = 0.9');
