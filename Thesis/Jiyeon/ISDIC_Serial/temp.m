clear all;
close all;
format shortE;
tic

Tx = 3;
Rx = 3;
result = [];
Error_Limit = 10^-5;
checkNumber = 3;            % ëª? ë²? ê°™ì„ ?•Œ ?‹¤?–‰?•  ê²ƒì¸ì§? ê²°ì •?•˜?Š” ?ˆ«?

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
        h_Dot_s_Sum = 0;
        
        
        for i=1:1:Tx
            h_Dot_s_Sum = h_Dot_s_Sum + h(:,i)*s(i);
        end
        
        ISDIC_disabled = zeros(Tx,1);
        omiited_counter = 0;
        while checkEscape == 0
            % loop start
            
            for i=1:1:Tx
               if ISDIC_disabled(i) ==0               
               else
                   omiited_counter = omiited_counter + 1;
               end
            end
            
           ISDIC_disabled(i) = isequal(checkSymbol(:,it), checkSymbol(:,it+1));
           
            % check loop
            checkEscape = 1;
            checkSymbol(:,checkNumber) = estimateSymbol;

            for i=1:1:checkNumber - 1
                checkEscape = checkEscape * isequal(checkSymbol(:,i), checkSymbol(:,i+1));
            end
            checkSymbol(:,1) = [];
            
            escapeTrial = escapeTrial+1;
            if escapeTrial > 7
                break
            end
            
            % loop end
        end
       
        omiited_counter / (Tx * total_iteration) 
        Demo_symbol = checkSymbol(:,end);
                
        % modulation
%         Demo_symbol = MMSE_Modulation(Tx, Rx, N, symbol);
        % ZF(Rx,Tx,N,symbol)
        % MMSE(Rx,Tx,N,symbol)
        
        % demodulation
        Demo_result(:,1) = real(Demo_symbol)>0; % MRC?Š” ì¶”í›„ ë³?ê²½í•˜ê¸?
        Demo_result(:,2) = imag(Demo_symbol)>0;
        
        % count error
        error = error + sum(abs(bit-Demo_result), 'all');
        
    end
    
    error = error / (trial * 2 * Tx);
    fprintf("Tx ê°œìˆ˜ : %d / Rx ê°œìˆ˜ : %d / dB : %d / BER : %g \n", Tx, Rx, SNR, error);
    if Error_Limit > error
        break;
    end
    result = [result error];
end

% save mat file
[~, currentFileName,~] = fileparts(mfilename('fullpath'));

fileName = strcat(currentFileName, '_', string(Tx), 'x', string(Rx), '.mat');
% varName = strcat(currentFileName, '_', string(Tx), 'x', string(Rx), '_result');
QPSK_new_meta_MMSE_ISDIC_Serial_result_7 = result;
cd mat_folder % ?´?”ëª?

if (exist(fileName, 'file') > 0) 
    save(fileName, 'QPSK_new_meta_MMSE_ISDIC_Serial_result_7', '-append'); 
else
    save(fileName, 'QPSK_new_meta_MMSE_ISDIC_Serial_result_7');
end

cd ..

toc
