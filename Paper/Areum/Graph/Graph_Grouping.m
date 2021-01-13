clear all;

x=-4:4:20;
LineWidth = 1;
lim_y = 1E-8;
result_a = [];
result_b = [];
result_c = [];
result_d = [];
result_e = [];
result_f = [];
result_g = [];
result_h = [];
result_i = [];
result_serial_8 = [];

a = load(fullfile(pwd, '\result\ISDIC_8x8_Grouping_1_ordering_2.mat'));
b = load(fullfile(pwd, '\result\ISDIC_8x8_Grouping_2_ordering_2.mat'));
c = load(fullfile(pwd, '\result\ISDIC_8x8_Grouping_4_ordering_2.mat'));
d = load(fullfile(pwd, '\result\ISDIC_8x8_Grouping_8_ordering_2.mat'));
serial_8 = load(fullfile(pwd, '\result\ISDIC_8x8.mat'));

e = load(fullfile(pwd, '\result\ISDIC_16x16_Grouping_1.mat'));
f = load(fullfile(pwd, '\result\ISDIC_16x16_Grouping_2.mat'));
g = load(fullfile(pwd, '\result\ISDIC_16x16_Grouping_4.mat'));
h = load(fullfile(pwd, '\result\ISDIC_16x16_Grouping_8.mat'));
i = load(fullfile(pwd, '\result\ISDIC_16x16_Grouping_16.mat'));

for z = 1:5:35
    result_a = [result_a a.result(1,z)];
    result_b = [result_b b.result(1,z)];
    result_c = [result_c c.result(1,z)];
    result_d = [result_d d.result(1,z)];
    result_serial_8 = [result_serial_8 serial_8.result(1,z)];
end

% for z = 1:2
%    % result_d = [result_d 0];
%     result_serial_8 = [result_serial_8 0];
% end
for z = 1:5:20
    result_e = [result_e e.result(1,z)];
end
result_e = [result_e 0 0];
for z = 1:5:30
    result_f = [result_f f.result(1,z)];
    result_g = [result_g g.result(1,z)];
    result_h = [result_h h.result(1,z)];
    result_i = [result_i i.result(1,z)];
end

figure(1);
semilogy(x,result_a); hold on;
semilogy(x,result_b); hold on;
semilogy(x,result_c); hold on;
semilogy(x,result_d); hold on;
semilogy(x,result_serial_8); hold on;

ylabel('BER ---->');
xlabel('SNR ---->');
title('ISDIC Serial 8x8');

legend({'Grouping 1','Grouping 2','Grouping 4','Grouping 8','ISDIC serial'},'Location','southwest')

x=0:4:20;
figure(2);
semilogy(x,result_e); hold on;
semilogy(x,result_f); hold on;
semilogy(x,result_g); hold on;
semilogy(x,result_h); hold on;
semilogy(x,result_i); hold on;
ylabel('BER ---->');
xlabel('SNR ---->');
title('ISDIC Serial 16x16');

legend({'Grouping 1','Grouping 2','Grouping 4','Grouping 8','Grouping 16'},'Location','southwest')
