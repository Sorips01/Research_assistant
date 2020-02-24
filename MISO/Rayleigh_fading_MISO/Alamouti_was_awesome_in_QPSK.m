%clc;
clear all;
close all;
tic

%message=randi([0,1],1,1000000);  %OK

Alamouti_QPSK_BER = [];
Alamouti_QPSK_SER = [];

% symbol=zeros(1,length(message)/2);      

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
Tx_count = 2;
Rx_count = 1;
Alamouti_QPSK_BER = [Alamouti_QPSK_BER; Vector_Demodulation(Tx_count, Rx_count)];


cd ..
cd mat_Rayleigh_fading_MISO

if (exist('QPSK_Rayleigh_MISO.mat', 'file') > 0)
    save('QPSK_Rayleigh_MISO.mat', 'Alamouti_QPSK_BER', '-append');
else
    save('QPSK_Rayleigh_MISO.mat', 'Alamouti_QPSK_BER');
end
cd ..
cd Rayleigh_fading_MISO

toc
    