clear all;

x=-4:2:4;
LineWidth = 1;
lim_y = 1E-8;
result_a = [];
result_b = [];
result_c = [];
result_d = [];
result_serial_8 = [];
result_serial_16 = [];

a = load(fullfile(pwd, '\result\ISDIC_8x16_Grouping_1_ordering_2.mat'));
b = load(fullfile(pwd, '\result\ISDIC_8x16_Grouping_2_ordering_2.mat'));
c = load(fullfile(pwd, '\result\ISDIC_8x16_Grouping_4_ordering_2.mat'));
d = load(fullfile(pwd, '\result\ISDIC_8x16_Grouping_8_ordering_2.mat'));
% serial_8 = load(fullfile(pwd, '\result\ISDIC_8x8.mat'));
MMSE_8x16 = load(fullfile(pwd, '\result\QPSK_new_meta_MMSE.mat'));

for z = 1:5:15
    result_a = [result_a a.result(1,z)];
%     result_serial_8 = [result_serial_8 serial_8.result(1,z)];
end
for z = 1:5:25
    result_b = [result_b b.result(1,z)];
    result_c = [result_c c.result(1,z)];
    result_d = [result_d d.result(1,z)];
end

result_a = [result_a 0 0];
MMSE_8x16.MMSE_result8x16 = [MMSE_8x16.MMSE_result8x16 0];

figure(1);
semilogy(x,result_a); hold on;
semilogy(x,result_b); hold on;
semilogy(x,result_c); hold on;
semilogy(x,result_d); hold on;
% semilogy(x,result_serial_8); hold on;
semilogy(x,MMSE_8x16.MMSE_result8x16); hold on;

ylabel('BER ---->');
xlabel('SNR ---->');
title('ISDIC Serial 8x16');

legend({'Grouping 1','Grouping 2','Grouping 4','Grouping 8','MMSE'},'Location','southwest')


