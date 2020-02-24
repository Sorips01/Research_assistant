%clc;
clear all;
close all;
tic

%message=randi([0,1],1,1000000);  %OK

Alamouti_BER = [];
Alamouti_SER = [];

symbol=zeros(1,length(message)/2);      

%====symbolization====    OK
% k = 1;
% for j = 1:2:(length(message)-1)
% 
%     if(message(j) == 0 && message(j+1) == 0)
%        symbol(k) = -1-1i;
%        k = k+1;
%     elseif(message(j) == 0 && message(j+1) == 1)
%        symbol(k) = -1+1i;
%        k = k+1;
%     elseif(message(j) == 1 && message(j+1) == 0)
%        symbol(k) = 1-1i;
%        k = k+1;
%     else
%       symbol(k) = 1+1i;
%       k = k+1;
%     end
%     
% end


%====demodulation====
TX_count = 2;
RX_count = 1;
Alamouti_QPSK_BER = [Alamouti_BER; Vector_Demodulation(Tx_count, RX_count)];


% cd ..
% cd mat_Rayleigh_fading_SIMO
% 
% if (exist('RX_2_EGC_QPSK_Rayleigh_SIMO.mat', 'file') > 0)
%     save('RX_2_EGC_QPSK_Rayleigh_SIMO.mat', 'QPSK_BER_EGC_RX_2', '-append');
% else
%     save('RX_2_EGC_QPSK_Rayleigh_SIMO.mat', 'QPSK_BER_EGC_RX_2');
% end
% cd ..
% cd SIMO_MRC_EGC_SC

toc
    