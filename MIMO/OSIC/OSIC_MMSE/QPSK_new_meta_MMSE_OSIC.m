clear all;
close all;
format shortE;
tic

Tx = 3;
Rx = 3;
count = Tx;

result = [];
Demo_symbol = [];
Error_Limit = 10^-5;

for SNR = 0:5:60
    S = 2;
    N = S*10^(-0.1*SNR);
    error = zeros(1,1);
    trial = 0;
    while error < 1000      
        trial= trial + 1;
        sizeEye = Tx;
        
        % creat bit
        bit = randi([0,1],Tx,2);
        
        % creat symbol
        symbol = 2 * bit - 1;
        symbol = symbol(:,1) + symbol(:,2) * 1j;
        
        h = (randn(Rx,Tx) + 1j * randn(Rx,Tx))/sqrt(2);
        noise = (randn(Rx,1) + 1j * randn(Rx,1)) * sqrt(N/2);
        r = h*symbol + noise;
        Demo_symbol = [];

        [value index] =sort(sum(abs(h)),'descend');
         
        

        % modulation
        for i = 1:1:count

            r_result = MMSE_Modulation(N,sizeEye,r, h);
            Demo_symbol = [Demo_symbol; r_result(1,:)];
            if i ~= count  
               
                [r,h] = OSIC(r_result,h,r);

            end
            
            sizeEye = sizeEye-1;
          
        end
        
        for v =1:1:count
             osicResult(index(v)) = Demo_symbol(v);
        end
        
        
        
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
    if  Error_Limit > error
        break;
    end
    result = [result error];
end

% save mat file
OSIC_result = result;
MMSE_OSIC_result_4x4 = OSIC_result;

fileName = 'QPSK_new_meta_OSIC.mat';
fileResult = 'MMSE_OSIC_result_3x3';

cd mat_folder % 폴더명

if (exist(fileName, 'file') > 0) 
    save(fileName, fileResult, '-append'); 
else
    save(fileName, fileResult);
end

cd ..

toc