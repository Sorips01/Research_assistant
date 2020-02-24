%clc;
clear all;
close all;
tic
format shortE;
message=randi([0,1],1,1000000);  %OK

QPSK_BER_MRT=[];
QPSK_BER_Selection=[];

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

% MRT
TX_count = 2;
QPSK_BER_MRT = [QPSK_BER_MRT; Demodulation(message, symbol, TX_count, 1)];
TX_count = 3;
QPSK_BER_MRT = [QPSK_BER_MRT; Demodulation(message, symbol, TX_count, 1)];
TX_count = 4;
QPSK_BER_MRT = [QPSK_BER_MRT; Demodulation(message, symbol, TX_count, 1)];

cd ..
cd mat_Rayleigh_fading_MISO

if (exist('MRT_QPSK_Rayleigh_MISO.mat', 'file') > 0)
    save('MRT_QPSK_Rayleigh_MISO.mat', 'QPSK_BER_MRT', '-append');
else
    save('MRT_QPSK_Rayleigh_MISO.mat', 'QPSK_BER_MRT');
end

cd ..
cd MISO

disp(mfilename('Class'))
    