clear all

load('QPSK_new_meta_MMSE_ISDIC_Parallel_3x3.mat')
x=0:5:60;
LineWidth = 1;
lim_y = 1E-8;

y = MMSE_ISDIC_Parallel_result3x3;

y = length_normalize(x, y);
semilogy(x,y, 'LineWidth', LineWidth);

