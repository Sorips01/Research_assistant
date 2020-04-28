clear all;
close all;
format shortE;
tic

Tx = 4;
Rx = 4;
count = Tx;
result = [];
Demo_symbol = [];
Error_Limit = 10^-5;

for SNR = 0:5:60
    N = 10^(-0.1*SNR);
    error = zeros(1,1);
    trial = 0;
    while error < 1000      
        trial= trial + 1;
        
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
           
            r_result = ZF_Modulation(r, h);
            Demo_symbol = [Demo_symbol; r_result(1,:)];
            if i ~= count
                [r,h] = SIC(r_result,h,r);
            end    
                  
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
OSIC_result_4x4 = result;

cd mat_folder % 폴더명

if (exist('QPSK_new_meta_OSIC.mat', 'file') > 0) 
    save('QPSK_new_meta_OSIC.mat', 'SIC_result_4x4', '-append'); 
else
    save('QPSK_new_meta_SIC.mat', 'SIC_result_4x4');
end

cd ..

toc
