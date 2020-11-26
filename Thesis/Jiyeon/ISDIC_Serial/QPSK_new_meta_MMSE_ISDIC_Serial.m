clear all;
close all;
format shortE;
tic

Tx = 3;
Rx = 3;
result = [];
Error_Limit = 10^-5;
checkNumber = 3;            % 몇 번 같을 때 실행할 것인지 결정하는 숫자

for SNR = 0:2:12
    
    N = 1*10^(-0.1*SNR);
    error = zeros(1,1);
    trial = 0;
    
    while error < 1000
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
        
        escapeTrial = 0;
        h_Dot_s_Sum = 0;
        
        
        %% ISDIC
        for i=1:1:Tx
            h_Dot_s_Sum = h_Dot_s_Sum + h(:,i)*s(i);
        end
        
        %         ISDIC_disabled = zeros(Tx,1);
        %         omiited_counter = 0;
        
        
        temp = ones(Tx,1); % 추정하려는 값
        iteration = 1;
        
        while isempty(temp) ~= 1 %temp 가 비어있지 않는 동안은 계속 실행
            % loop start
            
            %             temp = h_Dot_s_Sum;
            for i= 1:1:Tx
                temp= s;
                h_Dot_s_Sum = 0;
                
                for j=1:1:Tx
                    h_Dot_s_Sum = h_Dot_s_Sum + h(:,j)*s(j);
                end
                
                rSerial(:,:,i) = r - (h_Dot_s_Sum) + (h(:,i) * s(i));
                
                D(:,:,i) = v .* eye(Tx);
                D(i,i,i) = 1;
                
                f(:,:,i) = conj(h(:,i).') * inv(h * D(:,:,i) * conj(h.') + N * eye(Rx));
                
                b(:,:,i) = f(:,:,i) * h(:,i);
                
                a_q = [1+1i, 1-1i, -1+1i, -1-1i] / sqrt(2);
                
                p(:,:,i) = exp((-1 * abs(f(:,:,i) * rSerial(:,:,i) - a_q * b(:,:,i)).^2 / (b(:,:,i) * (1 - b(:,:,i)) ) ) ); % a_q 없음 추가해야됨
                if isnan(p(:,:,i))
                    p(:,:,i) = exp((-1 * abs(f(:,:,i) * rSerial(:,:,i) - a_q * b(:,:,i)).^2 / (b(:,:,i) * (1 - b(:,:,i)) ) ) ) * 10^300;
                end
                
                o = p == 0;     % p가 0에 너무 가까워졌을 경우 1을 o에 저장
                p(o) = p(o) + 10^-300;
                
                s(i) = sum(a_q .* p(:,:,i)) / sum(p(:,:,i));
                v(i) = sum(abs(a_q - s(i)).^2 .* p(:,:,i)) / sum(p(:,:,i));
                
                if isequal(temp(i),s(i))
                    temp(i) = [];   %추정된 값이 temp에 있는 값과 같으면 삭제
                else
                    iteration = iteration + 1;
                end
                %% Check Loop(삭제)
                %                 checkEscape = 1;
                %                 checkSymbol(:,checkNumber) = estimateSymbol;
                
                %                 for k = 1:1:checkNumber - 1
                %                     checkEscape = checkEscape * isequal(checkSymbol(:,k), checkSymbol(:,k+1)); % 하나라도 같으면 CheckEscape==0 이므로 끝
                %                 end
                
            end
            %
            %             for k = 1:1:length(temp)
            %                 if isequal(temp(k),s(k))
            %                     temp(k) = [];   %추정된 값이 temp에 있는 값과 같으면 삭제
            %                 end
            %             end
            
            estimateSymbol = EstimatingX(s);
            
            
            %             checkSymbol(:,1) = [];
            
            %                 escapeTrial = escapeTrial+1;
            %                 if escapeTrial > 7
            %                     break
            %                 end
            %
            % loop end
        end
        
        
        %% Demodulation
        %             omiitedAverage = omiited_counter / (Tx * total_iteration); % 평균 몇번째에 탈출하는지 계산
        %         Demo_symbol = checkSymbol(:,end);
        
        % modulation
        %         Demo_symbol = MMSE_Modulation(Tx, Rx, N, symbol);
        % ZF(Rx,Tx,N,symbol)
        % MMSE(Rx,Tx,N,symbol)
        
        % demodulation
        %         Demo_result(:,1) = real(Demo_symbol)>0;
        %         Demo_result(:,2) = imag(Demo_symbol)>0;
        %% Print BER
        % count error
%         error = error + sum(abs(bit-Demo_result), 'all');
        
    end
    %     end
    error = error / (trial * 2 * Tx);
    fprintf("Tx 개수 : %d / Rx 개수 : %d / dB : %d / BER : %g \n", Tx, Rx, SNR, error);
    if Error_Limit > error
        break;
    end
    result = [result error];
end


%% Save Files
[~, currentFileName,~] = fileparts(mfilename('fullpath'));

fileName = strcat(currentFileName, '_', string(Tx), 'x', string(Rx), '.mat');
% varName = strcat(currentFileName, '_', string(Tx), 'x', string(Rx), '_result');
QPSK_new_meta_MMSE_ISDIC_Serial_result = result;
cd mat_folder % 폴더명

if (exist(fileName, 'file') > 0)
    save(fileName, 'QPSK_new_meta_MMSE_ISDIC_Serial_result', '-append');
else
    save(fileName, 'QPSK_new_meta_MMSE_ISDIC_Serial_result');
end

cd ..

toc
