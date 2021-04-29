clear all;
close all;
format short e;
warning('off','all');
tic

% QPSK MMSE ISDIC Serial

ordering = 3; %201204 - 1: Tx ??‹š?ê½? æ¹²ê³•ì»?, 2: Channel ?ê²•æ¹²? æ¹²ê³•ì»?, 3: MMSE SINR
Tx = 16;
Rx = 16;
result = [];
cal = [];
Error_Limit = 5*10^-5;
checkNumber = 2;            % ï§?? è¸?? åª›ìˆˆ?“£ ?ë¸? ??–Ž?ë»??ë¸? å¯ƒê»‹?”¤ï§?? å¯ƒê³—? ™?ë¸???’— ??‹½??˜„
max_iteration = 5;
maxP =0.9;
ommitCounter = [];

disp(maxP)

for SNR = -2:2:10
    N = 1*10^(-0.1*SNR);
    error = zeros(1,max_iteration);
    tx_enabled_sum = zeros(1,max_iteration);
    tx_enabled_sum_final = zeros(1,max_iteration);
    trial = 0;
    final_symbols = zeros(Tx, 5);
    
    
    %     while min(error) < 500
    while trial<=10000
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
        if ordering == 1 %% TX ??‹š?ê½? æ¹²ê³•ì»? ordering
            order = 1:Tx;
        elseif ordering == 2 %% ï§?ê¾¨ê¼¸ ?ê²•æ¹²? æ¹²ê³•ì»? ordering
            [~, order] = sort(sum(abs(h).^2),'descend');
        elseif ordering == 3 %% MMSE SINR æ¹²ê³•ì»? ordering
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
        temp = ones(Tx,1); % ì¶”ì •?•˜? ¤?Š” ê°?
        iteration = 1;
        txEnabled = ones(Tx,1);
        
        
        counter = 0;
        
        for iteration=1:max_iteration
            tx_enabled_sum(iteration) = tx_enabled_sum(iteration)+sum(txEnabled);
            %             escape = iteration;
            %             counter = counter +1;
            if(sum(txEnabled) == 0)
                for k=iteration:max_iteration
                    final_symbols(:, k) = final_symbols(:,iteration-1);
                end
                %                 escape = iteration;
                
                break;
            else
                for i=order
                    
                    h_Dot_s_Sum = 0;
                    
                    if txEnabled(i) ==1
                        
                        counter = counter +1;
                        
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
                        
                        comP = max(p(:,:,i)/sum(p(:,:,i)));
                        if (comP > maxP )
                            %abs(temp(i)-s(i))<v(i)
                            %old_p(:,:,i) - p_(:,:,i)
                            %max(p(:,:,i)) > 0.9
                            txEnabled(i) = 0;
                            comP;
                            txEnabled;
                        end
                        
                        
                        estimateSymbol = EstimatingX(s);
                        
                        
                    end
                end
                
                final_symbols(:, iteration) = estimateSymbol;
                
                
            end
            
            
            
        end
        ommitCounter = [ommitCounter counter];
        
        tx_enabled_sum_final(1) = tx_enabled_sum(1);
        for iteration=2:max_iteration
            tx_enabled_sum_final(iteration) = tx_enabled_sum_final(iteration-1) + tx_enabled_sum(iteration);
        end
        
        for iteration=1:max_iteration
            %% demodulation
            Demo_result(:,1) = real(final_symbols(:, iteration))>0; % MRC??’— ?•°ë·??‘ è¹??å¯ƒì?ë¸?æ¹??
            Demo_result(:,2) = imag(final_symbols(:, iteration))>0;
            error(iteration) = error(iteration) + sum(abs(bit-Demo_result), 'all');
        end
        
        if min(error)>100
            error = error;
        end
    end
    
    error = error / (trial * 2 * Tx);
    calculation = tx_enabled_sum_final./(trial*Tx*(1:max_iteration));
    fprintf("Tx : %d / Rx : %d / dB : %d / ", Tx, Rx, SNR);
    %     fprintf("Average Escape Iteration : %g / BER :",averageEscape);
    fprintf("\n");
    fprintf(" %g ",  error);
    fprintf("\n");
    fprintf(" %g ", calculation);
    fprintf("\n");
    if Error_Limit > error
        break;
    end
    result = [result error];
    cal = [cal calculation];
end
result.';
cal.';

%% Save Files
[~, currentFileName,~] = fileparts(mfilename('fullpath'));

% fileName = strcat(currentFileName, '_', string(Tx), 'x', string(Rx), '.mat');
fileName = strcat(pwd,'\result\', 'ISDIC_', string(Tx), 'x', string(Rx), '_Iteration_',string(maxP ), '.mat');
% varName = strcat(currentFileName, '_', string(Tx), 'x', string(Rx), '_result');

%  cd mat_folder % ?´?”ëª?

if (exist(fileName, 'file') > 0)
    save(fileName, 'result','cal','-append');
else
    save(fileName, 'result','cal');
end

cd ..

toc

