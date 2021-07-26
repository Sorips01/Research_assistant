function result = ISDIC_Serial_QR_func(Tx, Rx)
    format shortE;
    warning('off','all');
    tic

    % QPSK MMSE ISDIC Serial
    ordering = 3; %201204 - 1: Tx ?닚?꽌 湲곕컲, 2: Channel ?겕湲? 湲곕컲, 3: MMSE SINR
    % Tx = 4;
    % Rx = 4;
    result = [];
    Error_Limit = 10^-5;
    checkNumber = 2;            % 몇 번 같을 때 실행할 것인지 결정하는 숫자 // 미사용
    max_iteration = 5;

    for SNR = -14:2:14
        RandStream.setGlobalStream(RandStream('mt19937ar','seed',333));
        N = 1*10^(-0.1*SNR);
        error = zeros(1,max_iteration);
        trial = 0;
        final_symbols = zeros(Tx, 5);
        while error < 1000      
            trial= trial + 1;

            %% Create bit
            bit = randi([0,1],Tx,2);

            %% Create Symbol & receive Symbol
            symbol = 2 * bit - 1;
            symbol = (symbol(:,1) + symbol(:,2) * 1j)/sqrt(2);

            h = (randn(Rx,Tx) + 1j * randn(Rx,Tx))/sqrt(2);
            noise = (randn(Rx,1) + 1j * randn(Rx,1)) * sqrt(N/2);
            r = h * symbol + noise;

            %% QR Analysis
            Q_H = QR(h);        % Q_H is Hermitian Q
            r = Q_H * r;
            h = Q_H * h;
            n = Q_H * noise;

            %% create vector
            s = zeros(Tx,1);
            v = ones(Tx,1);
            checkSymbol = zeros(Tx, checkNumber);   % 미사용
            checkEscape = 0;    % 미사용

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

            escapeTrial = 0;
            a_q = [1+1i, 1-1i, -1+1i, -1-1i] / sqrt(2);
            %% ISDIC Start
            for iteration = 1:5
                for i=order
                    h_Dot_s_Sum = 0;
                    for j=1:1:Tx
                       h_Dot_s_Sum = h_Dot_s_Sum + h(:,j)*s(j);
                    end
                    rParallel(:,:,i) = r - (h_Dot_s_Sum) + h(:,i)*s(i);

                    D(:,:,i) = v .* eye(Tx);
                    D(i,i,i) = 1;

                    f(:,:,i) = conj(h(:,i).') * inv(h * D(:,:,i) * conj(h.') + N * eye(Rx));

                    b(:,:,i) = f(:,:,i) * h(:,i);

                    p(:,:,i) = exp((-1 * abs(f(:,:,i) * rParallel(:,:,i) - a_q * b(:,:,i)).^2 / (b(:,:,i) * (1 - b(:,:,i)) ) ) ); % a_q 없음 추가해야됨
                    if isnan(p(:,:,i)) 
                        p(:,:,i) = exp((-1 * abs(f(:,:,i) * rParallel(:,:,i) - a_q * b(:,:,i)).^2 / (b(:,:,i) * (1 - b(:,:,i)) ) ) ) * 10^300;
                    end

                    o = p == 0;
                    p(o) = p(o) + 10^-300;

                    s(i) = sum(a_q .* p(:,:,i)) / sum(p(:,:,i));

                    v(i) = sum(abs(a_q - s(i)).^2 .* p(:,:,i)) / sum(p(:,:,i));
                    estimateSymbol = EstimatingX(s);
                end
                final_symbols(:, iteration) = estimateSymbol;
            end
            for iteration=1:max_iteration            
                %% demodulation
                Demo_result(:,1) = real(final_symbols(:, iteration))>0; % MRC?뒗 異뷀썑 蹂?寃쏀븯湲?
                Demo_result(:,2) = imag(final_symbols(:, iteration))>0;
                error(iteration) = error(iteration) + sum(abs(bit-Demo_result), 'all');
            end
        end

        error = error / (trial * 2 * Tx);
        fprintf("Tx 개수 : %d / Rx 개수 : %d / dB : %d / BER : ", Tx, Rx, SNR);
        fprintf("%g /",  error);
        fprintf("\n");
        if Error_Limit > error
            break;
        end
        result = [result; error];
    end

    % save mat file
    [~, currentFileName,~] = fileparts(mfilename('fullpath'));

    fileName = strcat(pwd,'\result\', 'ISDIC_', string(Tx), 'x', string(Rx), '_QR', '.mat');


    if (exist(fileName, 'file') > 0) 
        save(fileName, 'result', '-append'); 
    else
        save(fileName, 'result');
    end

    % cd ..

    toc
end