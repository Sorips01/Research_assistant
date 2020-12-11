clear all;
close all;
format short e;
warning('off','all');
tic

% QPSK MMSE ISDIC Serial
ordering = 3; %201204 - 1: Tx ?ˆœ?„œ ê¸°ë°˜, 2: Channel ?¬ê¸? ê¸°ë°˜, 3: MMSE SINR
Tx = 8;
Rx = 8;
result = [];
Error_Limit = 10^-5;
checkNumber = 2;            % ëª? ë²? ê°™ì„ ?•Œ ?‹¤?–‰?•  ê²ƒì¸ì§? ê²°ì •?•˜?Š” ?ˆ«?
max_iteration = 5;
for SNR = 0:4:8
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
        
%         %% QR Analysis
%         Q_H = QR(h);        % Q_H is Hermitian Q
%         r = Q_H * r;
%         h = Q_H * h;
%         n = Q_H * noise;
        
        %% create vector
        s = zeros(Tx,1);
        v = ones(Tx,1);
        checkSymbol = zeros(Tx, checkNumber);
        checkEscape = 0;

        %201204
        if ordering == 1 %% TX ?ˆœ?„œ ê¸°ë°˜ ordering
            order = 1:Tx; 
        elseif ordering == 2 %% ì±„ë„ ?¬ê¸? ê¸°ë°˜ ordering
            [~, order] = sort(sum(abs(h).^2),'descend');
        elseif ordering == 3 %% MMSE SINR ê¸°ë°˜ ordering
            G_mmse = ((h*h'+N * eye(Rx))\h)';
            for i=1:Tx
                ordermean(i) = real(G_mmse(i,:)*h(:,i));
            end
            snr_value = ordermean./(1-ordermean);
            [~, order] = sort(snr_value,'descend');
        end
        escapeTrial = 0;
        a_q = [1+1i, 1-1i, -1+1i, -1-1i] / sqrt(2);
        %% ISDIC Start
        for iteration=1:5
            for i=order
                h_Dot_s_Sum = 0;
                for j=1:1:Tx
                   h_Dot_s_Sum = h_Dot_s_Sum + h(:,j)*s(j);
                end
                rParallel(:,:,i) = r - (h_Dot_s_Sum) + h(:,i)*s(i);
           
                D(:,:,i) = v .* eye(Tx);
                D(i,i,i) = 1;
            
                f(:,:,i) = conj(h(:,i).') * inv(h * D(:,:,i) * conj(h.') + N * eye(Rx));

                %201204
                b(:,:,i) = real(f(:,:,i) * h(:,i));                 
                
                %201204
                p(:,:,i) = (-1 * abs(f(:,:,i) * rParallel(:,:,i) - a_q * b(:,:,i)).^2 / (b(:,:,i) * (1 - b(:,:,i)) ) );
                p(:,:,i) = exp(p(:,:,i) + (700-max(p(:,:,i))));
                
                
            
                s(i) = sum(a_q .* p(:,:,i)) / sum(p(:,:,i));
            
                v(i) = sum(abs(a_q - s(i)).^2 .* p(:,:,i)) / sum(p(:,:,i));
                estimateSymbol = EstimatingX(s);
            end
            final_symbols(:, iteration) = estimateSymbol;             
        end
        
        for iteration=1:max_iteration            
            %% demodulation
            Demo_result(:,1) = real(final_symbols(:, iteration))>0; % MRC?Š” ì¶”í›„ ë³?ê²½í•˜ê¸?
            Demo_result(:,2) = imag(final_symbols(:, iteration))>0;
            error(iteration) = error(iteration) + sum(abs(bit-Demo_result), 'all');
        end
    end
    
    error = error / (trial * 2 * Tx)
    %fprintf("Tx ê°œìˆ˜ : %d / Rx ê°œìˆ˜ : %d / dB : %d / BER : %g \n", Tx, Rx, SNR, error);
    if Error_Limit > error
        break;
    end
    result = [result error];
end
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
