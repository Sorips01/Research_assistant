clear all;

x=0:4:16;
LineWidth = 1;
lim_y = 1E-8;
result_a = [];
result_b = [];
result_c = [];

a = load(fullfile(pwd, '\result\ISDIC_8x8_Grouping_1.mat'));
b = load(fullfile(pwd, '\result\ISDIC_8x8_Grouping_2.mat'));
c = load(fullfile(pwd, '\result\ISDIC_8x8_Grouping_4.mat'));

for i = 1:5:25
    result_a = [result_a a.result(1,i)];
    result_b = [result_b b.result(1,i)];
    result_c = [result_c c.result(1,i)];
end

semilogy(x,result_a); hold on;
semilogy(x,result_b); hold on;
semilogy(x,result_c); hold on;

ylabel('BER ---->');
xlabel('SNR ---->');
title('ISDIC Serial');

legend({'Grouping 1','Grouping 2','Grouping 4'},'Location','southwest')
