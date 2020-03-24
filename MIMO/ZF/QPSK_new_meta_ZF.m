mclear all;
close all;
format shortE;
tic

Tx = 2;
Rx = 4;
result = [];

for SNR=0:5:60
    N = 10^(-0.1*SNR);
    error = zeros(1,1);
    trial = 0;
    while error < 1000      
        trial= trial + 1;
        
        % creat bit
        bit = randi([0,1],2,1);
        
        % creat symbol
        symbol = (2*bit(1)-1 + j*(2*bit(2)-1))/sqrt(2);
        
        % modulation
        h = (randn(1,1)+j*randn(1,1))/sqrt(2);
        h = h * ones(Rx,1);
        noise = (randn(Rx,1)+j*randn(Rx,1))*sqrt(N/2);
        r = h*symbol+noise;
        % ZF(Rx,Tx,N,symbol)
        % MMSE(Rx,Tx,N,symbol)
        
        % demodulation
        Demo_result(1,1) = real(MRC)>0; % MRC는 추후 변경하기
        Demo_result(2,1) = imag(MRC)>0;
        
        % count error
        error = error + sum(abs(bit-Demo_result));
    end
    
    error = error / (trial*2);
    fprintf("Tx 개수 : %d / Rx 개수 : %d / dB : %d / BER : %g \n", Tx, Rx, SNR, error);
    result = [result;error];
end

% save mat file
ZF_result = result;
cd ..
cd mat_Rayleigh_fading_MISO % 폴더명

if (exist('MRT_QPSK_Rayleigh_MISO.mat', 'file') > 0) 
    save('MRT_QPSK_Rayleigh_MISO.mat', 'ZF_result', '-append'); 
else
    save('MRT_QPSK_Rayleigh_MISO.mat', 'ZF_result');
end

cd ..
cd Rayleigh_fading_MISO

toc
