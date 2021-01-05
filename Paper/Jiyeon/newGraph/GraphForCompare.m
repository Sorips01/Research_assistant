x=0:2:16;
LineWidth = 1.5;
lim_y = 1E-6;

w1 = load(fullfile(pwd, '\matFolder\ISDIC_4x4_Iteration_0.9.mat'));

w1 = reshape(w1.result,8,9);


% ISDIC_Serial_result_93 = length_normalize(x, w1);
% ISDIC_Serial_result_94 = length_normalize(x, w2);
% ISDIC_Serial_result_95 = length_normalize(x, w3);
% ISDIC_Serial_result_96 = length_normalize(x, w4);
% ISDIC_Serial_result_97 = length_normalize(x, w5);
% ISDIC_Serial_result_98 = length_normalize(x, w6);
ISDIC_Serial_result_09 = length_normalize(x, w1);

f1 = figure;
semilogy(x,ISDIC_Serial_result_09(1,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_09(2,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_09(3,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_09(4,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_09(5,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_09(6,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_09(7,:), 'LineWidth', LineWidth);
hold on;
semilogy(x,ISDIC_Serial_result_09(8,:), 'LineWidth', LineWidth);
hold on;



ylim([lim_y 1]);
ylabel('BER ---->');
xlabel('SNR ---->');
legend('iteration = 1','iteration = 2','iteration = 3','iteration = 4','iteration = 5','iteration = 6','iteration = 7','iteration = 8');
title('maxP = 0.9');
