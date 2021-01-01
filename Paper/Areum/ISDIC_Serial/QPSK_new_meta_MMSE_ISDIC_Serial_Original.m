clear all;
close all;
format shortE;
warning('off','all');
tic

% QPSK MMSE ISDIC Serial
ordering = 2;
Tx = 8;
Rx = 8;
result = [];
Error_Limit = 10^-5;
checkNumber = 2;            % 몇 번 같을 때 실행할 것인지 결정하는 숫자
max_iteration = 5;

for SNR = 0:4:20
    N = 1*10^(-0.1*SNR);
    error = zeros(1,max_iteration);
    trial = 0;
    final_symbols = zeros(Tx, 5);
    
    while min(error) < 500
        trial= trial + 1;
        
        % creat bit
        %% Making Symbol
        bit = randi([0,1],Tx,2);
        
        % creat symbol
        symbol = 2 * bit - 1;
        symbol = (symbol(:,1) + symbol(:,2) * 1j)/sqrt(2);
        
        h = (randn(Rx,Tx) + 1j * randn(Rx,Tx))/sqrt(2);
        noise = (randn(Rx,1) + 1j * randn(Rx,1)) * sqrt(N/2);
        r = h * symbol + noise;
        
        %% Create Vector
        s = zeros(Tx,1);
        v = ones(Tx,1);
        checkSymbol = zeros(Tx, checkNumber);
        checkEscape = 0;
        
        %% Ordering
        if ordering == 1 
            order = 1:Tx; 
        elseif ordering == 2 
            [~, order] = sort(sum(abs(h).^2),'descend');
        elseif ordering == 3 
            G_mmse = ((h*h'+N * eye(Rx))\h)';
            for i=1:Tx
                ordermean(i) = real(G_mmse(i,:)*h(:,i));
            end
            snr_value = ordermean./(1-ordermean);
            [~, order] = sort(snr_value,'descend');
        end
        
        %escapeTrial = 0;
        a_q = [1+1i, 1-1i, -1+1i, -1-1i] / sqrt(2);
                
      %%  ISDIC Start 
      for iteration=1:5
            for i=order
                h_Dot_s_Sum = 0;      
                for j=1:1:Tx
                    h_Dot_s_Sum = h_Dot_s_Sum + h(:,j)*s(j);
                end
                
                rParallel(:,:,i) = r - (h_Dot_s_Sum) + (h(:,i) * s(i));
                
                D(:,:,i) = v .* eye(Tx);
                D(i,i,i) = 1;
                
                f(:,:,i) = conj(h(:,i).') * inv(h * D(:,:,i) * conj(h.') + N * eye(Rx));
                
                b(:,:,i) = real(f(:,:,i) * h(:,i));
                
%                 a_q = [1+1i, 1-1i, -1+1i, -1-1i] / sqrt(2);
                
                p(:,:,i) = (-1 * abs(f(:,:,i) * rParallel(:,:,i) - a_q * b(:,:,i)).^2 / (b(:,:,i) * (1 - b(:,:,i)) ) );
                p(:,:,i) = exp(p(:,:,i) + (700-max(p(:,:,i))));
                
                s(i) = sum(a_q .* p(:,:,i)) / sum(p(:,:,i));
                v(i) = sum(abs(a_q - s(i)).^2 .* p(:,:,i)) / sum(p(:,:,i));
                
                estimateSymbol = EstimatingX(s);
             
            end
            final_symbols(:, iteration) = estimateSymbol;             
      end
        %% demodulation
        for iteration=1:max_iteration            
            Demo_result(:,1) = real(final_symbols(:, iteration))>0; 
            Demo_result(:,2) = imag(final_symbols(:, iteration))>0;
            error(iteration) = error(iteration) + sum(abs(bit-Demo_result), 'all');
        end      
    end
    error = error / (trial * 2 * Tx);
    %fprintf("Tx 媛쒖닔 : %d / Rx 媛쒖닔 : %d / dB : %d / BER : %g \n", Tx, Rx, SNR, error);
    fprintf("Tx 개수 : %d / Rx 개수 : %d / dB : %d / BER : ", Tx, Rx, SNR);
    fprintf("%g /",  error);
    fprintf("\n");
    if Error_Limit > error
        break;
    end
    result = [result error];
end
    %% Save Files
    result.'
% save mat file
[~, currentFileName,~] = fileparts(mfilename('fullpath'));
   
fileName = strcat(pwd,'\result\', 'ISDIC_', string(Tx), 'x', string(Rx), '.mat');


if (exist(fileName, 'file') > 0) 
    save(fileName, 'result', '-append'); 
else
    save(fileName, 'result');
end

% cd ..

toc
%     [~, currentFileName,~] = fileparts(mfilename('fullpath'));
%     
%     fileName = strcat(currentFileName, '_', string(Tx), 'x', string(Rx), '.mat');
%     % varName = strcat(currentFileName, '_', string(Tx), 'x', string(Rx), '_result');
%     QPSK_new_meta_MMSE_ISDIC_Serial_result = result;
%     cd mat_folder % 폴더명
%     
%     if (exist(fileName, 'file') > 0)
%         save(fileName, 'QPSK_new_meta_MMSE_ISDIC_Serial_result', '-append');
%     else
%         save(fileName, 'QPSK_new_meta_MMSE_ISDIC_Serial_result');
%     end
%     
%     cd ..
%     
%     toc
