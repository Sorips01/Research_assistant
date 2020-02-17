%clc;
%clearvars;
close all;
tic
format shortE;
message=randi([0,1],1,1000000);  %OK

QPSK_BER_MRC_RX_4=[];
QPSK_BER_EGC=[];
QPSK_BER_SC=[];

QPSK_SER=[];

symbol=zeros(1,length(message)/2);      

%====symbolization====    OK
k = 1;
for j = 1:2:(length(message)-1)

    if(message(j) == 0 && message(j+1) == 0)
       symbol(k) = -1-1i;
       k = k+1;
    elseif(message(j) == 0 && message(j+1) == 1)
       symbol(k) = -1+1i;
       k = k+1;
    elseif(message(j) == 1 && message(j+1) == 0)
       symbol(k) = 1-1i;
       k = k+1;
    else
      symbol(k) = 1+1i;
      k = k+1;
    end
    
end


%====demodulation====
RX_count = 4;

QPSK_BER_MRC_RX_4 = [QPSK_BER_MRC_RX_4; Demodulation(message, symbol, RX_count, 1)];

toc

cd ..
cd mat_Rayleigh_fading_SIMO

if (exist('RX_4_MRC_QPSK_Rayleigh_SIMO.mat', 'file') > 0)
    save('RX_4_MRC_QPSK_Rayleigh_SIMO.mat', 'QPSK_BER_MRC_RX_4', '-append');
else
    save('RX_4_MRC_QPSK_Rayleigh_SIMO.mat', 'QPSK_BER_MRC_RX_4');
end

cd ..
cd SIMO_MRC_EGC_SC

disp(mfilename('Class'))
        