clear all;
close all;
format short e;
warning('off','all');
tic

% QPSK MMSE ISDIC Serial

ordering = 3; %201204 - 1: Tx ?닚?꽌 湲곕컲, 2: Channel ?겕湲? 湲곕컲, 3: MMSE SINR
Tx = 4;
Rx = 4;
result = [];
Error_Limit = 10^-5;
checkNumber = 2;            % 紐? 踰? 媛숈쓣 ?븣 ?떎?뻾?븷 寃껋씤吏? 寃곗젙?븯?뒗 ?닽?옄
max_iteration = 8;
maxP = 0.98;
escape_iteration = [];


for SNR = 0:2:16
    N = 1*10^(-0.1*SNR);
    error = zeros(1,max_iteration);
    trial = 0;
    final_symbols = zeros(Tx, 5);
    
    while min(error) < 500
        trial= trial + 1;
        
        %% Create bit
        bit = randi([0,1],Tx,2);
        
        %% Create Symbol & receive Symbol
        symbol = 2 * bit - 1;
        symbol = (symbol(:,1) + symbol(:,2) * 1j)/sqrt(2);
        
        h = (randn(Rx,Tx) + 1j * randn(Rx,Tx))/sqrt(2);
        noise = (randn(Rx,1) + 1j * randn(Rx,1)) * sqrt(N/2);
        r = h * symbol + noise;
        
        
        %% create vector
        s = zeros(Tx,1);
        v = ones(Tx,1);
        checkSymbol = zeros(Tx, checkNumber);
        checkEscape = 0;
        
        %201204
        if ordering == 1 %% TX ?닚?꽌 湲곕컲 ordering
            order = 1:Tx;
        elseif ordering == 2 %% 梨꾨꼸 ?겕湲? 湲곕컲 ordering
            [~, order] = sort(sum(abs(h).^2),'descend');
        elseif ordering == 3 %% MMSE SINR 湲곕컲 ordering
            G_mmse = ((h*h'+N * eye(Rx))\h)';
            for i=1:Tx
                ordermean(i) = real(G_mmse(i,:)*h(:,i));
            end
            snr_value = ordermean./(1-ordermean);
            [~, order] = sort(snr_value,'descend');
        end
        
        %         escapeTrial = 0;
        a_q = [1+1i, 1-1i, -1+1i, -1-1i] / sqrt(2);
        
        %% ISDIC Start
        temp = ones(Tx,1); % 추정하려는 값
        iteration = 1;
        txEnabled = ones(Tx,1);
        counter = 0;
         escape_iteration = [];
        for iteration=1:max_iteration
            
             if(sum(txEnabled) == 0)
                    escape_iteration = [escape_iteration iteration];
                    break;
                 end
                 
            for i=order
                h_Dot_s_Sum = 0;
                
                
                
                if txEnabled(i) ==1
                    for j=1:1:Tx
                        h_Dot_s_Sum = h_Dot_s_Sum + h(:,j)*s(j);
                    end
                    
                    rParallel(:,:,i) = r - (h_Dot_s_Sum) + h(:,i)*s(i);
                    
                    D(:,:,i) = v .* eye(Tx);
                    D(i,i,i) = 1;
                    
                    f(:,:,i) = conj(h(:,i).') * inv(h * D(:,:,i) * conj(h.') + N * eye(Rx));
                    
                    %201204
                    b(:,:,i) = real(f(:,:,i) * h(:,i));
                    
                    %                     %201204
                    p(:,:,i) = exp(-1 * abs(f(:,:,i) * rParallel(:,:,i) - a_q * b(:,:,i)).^2 / (b(:,:,i) * (1 - b(:,:,i)) ) );
                    
                    s(i) = sum(a_q .* p(:,:,i)) / sum(p(:,:,i));
                    v(i) = sum(abs(a_q - s(i)).^2 .* p(:,:,i)) / sum(p(:,:,i));
                    
                    if (max(p(:,:,i)) > maxP )
                        %abs(temp(i)-s(i))<v(i)
                        %old_p(:,:,i) - p_(:,:,i)
                        %max(p(:,:,i)) > 0.9
                        txEnabled(i) = 0;
                    end
                    
                    
                    estimateSymbol = EstimatingX(s);
                    
                end
               
            end
            final_symbols(:, iteration) = estimateSymbol;
            averageEscape = sum(escape_iteration)/length(escape_iteration);
            
        end
        
        for iteration=1:max_iteration
            %% demodulation
            Demo_result(:,1) = real(final_symbols(:, iteration))>0; % MRC?뒗 異뷀썑 蹂?寃쏀븯湲?
            Demo_result(:,2) = imag(final_symbols(:, iteration))>0;
            error(iteration) = error(iteration) + sum(abs(bit-Demo_result), 'all');
            
            %                 averageCounter = sum(ommitCounter)/length(ommitCounter);
        end
        
    end
    
    error = error / (trial * 2 * Tx);
    fprintf("Tx 개수 : %d / Rx 개수 : %d / dB : %d / ", Tx, Rx, SNR);
    fprintf("Average Escape Iteration : %g / BER :",averageEscape);
    fprintf(" %g ",  error);
    fprintf("\n");
    if Error_Limit > error
        break;
    end
    result = [result error];
end
result.';

%% Save Files
[~, currentFileName,~] = fileparts(mfilename('fullpath'));

% fileName = strcat(currentFileName, '_', string(Tx), 'x', string(Rx), '.mat');
fileName = strcat(pwd,'\result\', 'ISDIC_', string(Tx), 'x', string(Rx), '_Iteration_',string(maxP ), '.mat');
% varName = strcat(currentFileName, '_', string(Tx), 'x', string(Rx), '_result');

%  cd mat_folder % 폴더명

if (exist(fileName, 'file') > 0)
    save(fileName, 'result', '-append');
else
    save(fileName, 'result');
end

cd ..

toc

