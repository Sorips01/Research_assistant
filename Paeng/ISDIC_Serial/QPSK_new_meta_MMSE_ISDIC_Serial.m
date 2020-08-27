clear all;
close all;
format shortE;
tic

Tx = 8;
Rx = 8;
result = [];
Error_Limit = 10^-5;
checkNumber = 2;            % 몇 번 같을 때 실행할 것인지 결정하는 숫자

for SNR = 0:5:60
    N = 1*10^(-0.1*SNR);
    error = zeros(1,1);
    trial = 0;
    while error < 1000      
        trial= trial + 1;
        
        % creat bit
        bit = randi([0,1],Tx,2);
        
        % creat symbol
        symbol = 2 * bit - 1;
        symbol = (symbol(:,1) + symbol(:,2) * 1j)/sqrt(2);
        
        h = (randn(Rx,Tx) + 1j * randn(Rx,Tx))/sqrt(2);
        noise = (randn(Rx,1) + 1j * randn(Rx,1)) * sqrt(N/2);
        r = h * symbol + noise;
        
        % create vector
        s = zeros(Tx,1);
        v = ones(Tx,1);
        checkSymbol = zeros(Tx, checkNumber);
        checkEscape = 0;
        
        escapeTrial = 0;
        
        while checkEscape == 0
            % loop start
            h_Dot_s_Sum = 0;
            for i=1:1:Tx
               h_Dot_s_Sum = h_Dot_s_Sum + h(:,i)*s(i);
            
            
                rParallel(:,:,i) = r - (h_Dot_s_Sum) + (h(:,i) * s(i));
            
                D(:,:,i) = v .* eye(Tx);
                D(i,i,i) = 1;
            

            
                f(:,:,i) = conj(h(:,i).') * inv(h * D(:,:,i) * conj(h.') + N * eye(Rx));
            
                b(:,:,i) = f(:,:,i) * h(:,i);
            

                a_q = [1+1i, 1-1i, -1+1i, -1-1i] / sqrt(2);

            
                p(:,:,i) = exp((-1 * abs(f(:,:,i) * rParallel(:,:,i) - a_q * b(:,:,i)).^2 / (b(:,:,i) * (1 - b(:,:,i)) ) ) ); % a_q 없음 추가해야됨
                if isnan(p(:,:,i)) 
                    p(:,:,i) = exp((-1 * abs(f(:,:,i) * rParallel(:,:,i) - a_q * b(:,:,i)).^2 / (b(:,:,i) * (1 - b(:,:,i)) ) ) ) * 10^300;
                end
            
                o = p == 0;
                p(o) = p(o) + 10^-300;
            

            
               s(i) = sum(a_q .* p(:,:,i)) / sum(p(:,:,i));
            

            
                v(i) = sum(abs(a_q - s(i)).^2 .* p(:,:,i)) / sum(p(:,:,i));
            end
            
            estimateSymbol = EstimatingX(s);
            % check loop
            checkEscape = 1;
            checkSymbol(:,checkNumber) = estimateSymbol;

            for i=1:1:checkNumber - 1
                checkEscape = checkEscape * isequal(checkSymbol(:,i), checkSymbol(:,i+1));
            end
            checkSymbol(:,1) = [];
            
            escapeTrial = escapeTrial+1;
            if escapeTrial > 5
                break
            end
            
            % loop end
        end
       
        
        Demo_symbol = checkSymbol(:,end);
                
        % modulation
%         Demo_symbol = MMSE_Modulation(Tx, Rx, N, symbol);
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
[~, currentFileName,~] = fileparts(mfilename('fullpath'));

fileName = strcat(currentFileName, '_', string(Tx), 'x', string(Rx), '.mat');
% varName = strcat(currentFileName, '_', string(Tx), 'x', string(Rx), '_result');
QPSK_new_meta_MMSE_ISDIC_Parallel_result_8x8 = result;
cd mat_folder % 폴더명

if (exist(fileName, 'file') > 0) 
    save(fileName, QPSK_new_meta_MMSE_ISDIC_Parallel_result_8x8, '-append'); 
else
    save(fileName, QPSK_new_meta_MMSE_ISDIC_Parallel_result_8x8);
end

cd ..

toc
