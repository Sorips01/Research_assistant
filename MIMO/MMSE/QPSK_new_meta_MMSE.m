clear all;
close all;
format shortE;
tic

Tx = 8;
Rx = 8;
result = [];
Error_Limit = 10^-5;

for SNR = -4:4:20
    N = 2*10^(-0.1*SNR);
    error = zeros(1,1);
    trial = 0;
    while error < 500   
        trial= trial + 1;
        
        % creat bit
        bit = randi([0,1],Tx,2);
        
        % creat symbol
        symbol = 2 * bit - 1;
        symbol = symbol(:,1) + symbol(:,2) * 1j;
                
        % modulation
        Demo_symbol = MMSE_Modulation(Tx, Rx, N, symbol);
        % ZF(Rx,Tx,N,symbol)
        % MMSE(Rx,Tx,N,symbol)
        
        % demodulation
        Demo_result(:,1) = real(Demo_symbol)>0; % MRC는 추후 변경하기
        Demo_result(:,2) = imag(Demo_symbol)>0;
        
        % count error
        error = error + sum(abs(bit-Demo_result), 'all');
        
    end
    
    error = error / (trial * 2 * Tx);
    fprintf("Tx 개수 : %d / Rx 개수 : %d / dB : %d / BER : %g \n", Tx, Rx, SNR, error);
    if Error_Limit > error
        break;
    end
    result = [result error];
end

% save mat file
MMSE_result8x8 = result;

folderName = 'QPSK_new_meta_MMSE.mat'
fileName = 'MMSE_result8x8'
cd mat_folder % 폴더명

if (exist(folderName, 'file') > 0) 
    save(folderName, fileName, '-append'); 
else
    save(folderName, fileName);
end

cd ..

toc
