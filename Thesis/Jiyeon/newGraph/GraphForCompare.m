x=0:2:8;
LineWidth = 1.5;
lim_y = 1E-6;

% w1 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.93.mat'));
% w2 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.94.mat'));
% w3 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.95.mat'));
% w4 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.96.mat'));
% w5 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.97.mat'));
% w6 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.98.mat'));
w7 = load(fullfile(pwd, '\matFolder\ISDIC_8x8_Iteration_0.99.mat'));

% w1 = reshape(w1.result,5,6);
% w2 = reshape(w2.result,5,6);
% w3 = reshape(w3.result,5,6);
% w4 = reshape(w4.result,5,6);
% w5 = reshape(w5.result,5,6);
% w6 = reshape(w6.result,5,6);
w7 = reshape(w7.result,5,5);

% ISDIC_Serial_result_93 = length_normalize(x, w1);
% ISDIC_Serial_result_94 = length_normalize(x, w2);
% ISDIC_Serial_result_95 = length_normalize(x, w3);
% ISDIC_Serial_result_96 = length_normalize(x, w4);
% ISDIC_Serial_result_97 = length_normalize(x, w5);
% ISDIC_Serial_result_98 = length_normalize(x, w6);
ISDIC_Serial_result_99 = length_normalize(x, w7);

% 
% f1 = figure;
% semilogy(x,ISDIC_Serial_result_93(1,:), 'LineWidth', LineWidth);
% hold on;
% semilogy(x,ISDIC_Serial_result_94(1,:), 'LineWidth', LineWidth);
% hold on;
% semilogy(x,ISDIC_Serial_result_95(1,:), 'LineWidth', LineWidth);
% hold on;
% semilogy(x,ISDIC_Serial_result_96(1,:), 'LineWidth', LineWidth);
% hold on;
% semilogy(x,ISDIC_Serial_result_97(1,:), 'LineWidth', LineWidth);
% hold on;
% semilogy(x,ISDIC_Serial_result_98(1,:), 'LineWidth', LineWidth);
% hold on;
% semilogy(x,ISDIC_Serial_result_99(1,:), 'LineWidth', LineWidth);
% hold on;



% ylim([lim_y 1]);
% ylabel('BER ---->');
% xlabel('SNR ---->');
% legend('maxP = 0.93','maxP = 0.94','maxP = 0.95','maxP = 0.96','maxP = 0.97','maxP = 0.98');
% title('iteration = 1');
