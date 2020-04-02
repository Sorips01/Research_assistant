clear all;
close all;
format shortE;
tic


Tx = 2;
Rx = 2;

result = [];
Error_Limit = 10^-5;

% Make data X
x = zeros(Tx,4^Tx);
for i=0:4^Tx-1
    share = fix(i/4);
    remainder = rem(i,4);
    for j = Tx:-1:1
        x(j,i+1) = remainder;
        remainder = rem(share,4);
        share = fix(share/4);
    end
end

for k=1:1:length(x)*Tx
    if x(k) == 0
        x(k) = -1-1i;
    elseif x(k) == 1
        x(k) = -1+1i;
    elseif x(k) == 2
        x(k) = 1-1i;
    elseif x(k) == 3
        x(k) = 1+1i;
    end
end

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
                
        % modulation
        [Demo_symbol, h] = ML_Modulation(Tx, Rx, N, symbol);
        % ZF(Rx,Tx,N,symbol)
        % MMSE(Rx,Tx,N,symbol)
        
        % demodulation
        % Demo_result(:,1) = real(Demo_symbol)>0; 
        % Demo_result(:,2) = imag(Demo_symbol)>0;
        [~,index] = min(sum(abs(Demo_symbol - (h * x))),[],2); 
        Demo_symbol = x(:,index);
        
        Demo_result(:,1) = real(Demo_symbol)>0; 
        Demo_result(:,2) = imag(Demo_symbol)>0;
        
        % count error
        error = error + sum(abs(bit-Demo_result), 'all');
        
    end
    
    error = error / (trial * 2 * Tx);
    fprintf("Tx 개수 : %d / Rx 개수 : %d / dB : %d / BER : %g \n", Tx, Rx, SNR, error);
    result = [result error];
    if Error_Limit > error
        break;
    end
end

% save mat file

ML_result_2x2 = result;


cd mat_folder % 폴더명

if (exist('QPSK_new_meta_ML.mat', 'file') > 0) 

    save('QPSK_new_meta_ML.mat', 'ML_result_2x2', '-append'); 
else
    save('QPSK_new_meta_ML.mat', 'ML_result_2x2');

end

cd ..

toc
