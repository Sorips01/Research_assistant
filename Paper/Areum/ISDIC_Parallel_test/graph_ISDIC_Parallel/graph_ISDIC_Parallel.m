clear all
cd ..
cd mat_folder
load('QPSK_new_meta_MMSE_ISDIC_Parallel_8x8.mat')
cd ..
cd graph_ISDIC_Parallel
x=0:5:60;
LineWidth = 1;
lim_y = 1E-8;

y = QPSK_new_meta_MMSE_ISDIC_Parallel_result_8x8;

y = length_normalize(x, y);
semilogy(x,y, 'LineWidth', LineWidth);

