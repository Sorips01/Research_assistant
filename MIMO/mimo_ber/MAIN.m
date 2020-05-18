clear; close all; clc;
format short e;
Start_dB=0; dB_step=2; End_dB=100;

M = 2; % Modulation Order
Q = 2^M; % Total elements in Constellation Set
QAM = 1; %QAM Modulation is used. If PSK, value should be 0. Until M=2, QAM & PSK modulations are identical.
[bitset, symset] = Definition_Bit_Pre_Mapping(M, Q, QAM);
Tx=4; Rx=4;
number_of_bits_per_transmission = Tx * M;
va = 1 / sqrt(2);
BER_threshold = 0.001; % the scheme having a lower average BER in the previous simulations will not be executed.
bit_error_threshold = 20;
BER = [];
total_transmitted_bits = [];
number_of_tested_schemes = 8;
simulating = ones(number_of_tested_schemes,1);


fileID = fopen('result.txt','a');
start_time = sprintf('%s',datetime('now'));
fprintf(fileID, 'Simulaion Start: %s [Tx: %d, Rx: %d, Modulation Order: %d]\r\n', start_time, Tx, Rx, M);
pause(0.1);
fclose(fileID);

for SNR = Start_dB:dB_step:End_dB
    [E_S, noise_va, noise_dv, No_ES, ES_No, noise_I_Rx, noise_I_Tx, symset_mat] = Definition_Signal_Power_Noise(SNR, Rx, Tx, symset);
    %%% Error Related Function %%%
    bit_error = zeros(1,number_of_tested_schemes);  
    receiver = length(bit_error);
    tx_trial = 0;    
    
    while min(bit_error(simulating)) < bit_error_threshold || tx_trial < 1000
        tx_trial = tx_trial + 1;        
        %% transmitter        
        databits = randi([1 Q], Tx, 1);
        Tx_sym = symset(databits);
        databits_mod = mod(databits,Q);
        databits_bin = dec2bin(databits_mod,M);
        for i=1:M
            databits_mat(:,i) = bin2dec(databits_bin(:,i));
        end    
        
        %% channel
        ch = va*(randn(Rx,Tx)+1i*randn(Rx,Tx));         
        noise_vector = noise_dv*(randn(Rx,1)+1i*randn(Rx,1));
        Rx_sym = ch*Tx_sym + noise_vector;  
        

        %% receiver
        receiver = 0;
        % Linear ZF Detector
        receiver = receiver + 1;
        if simulating(receiver) == 1
            [detection_results] = Receiver_Linear_ZF(Tx, Rx, Rx_sym, ch, noise_va, symset, symset_mat, Q);        
            bit_result = bitset(detection_results,:);        
            bit_error(receiver) = bit_error(receiver) + sum(sum(abs(databits_mat - bit_result)));
        end

        % Linear MMSE Detector
        receiver = receiver + 1;
        if simulating(receiver) == 1
            [detection_results] = Receiver_Linear_MMSE(Tx, Rx, Rx_sym, ch, noise_va, symset, symset_mat, Q);        
            bit_result = bitset(detection_results,:);        
            bit_error(receiver) = bit_error(receiver) + sum(sum(abs(databits_mat - bit_result)));
        end
                
        % ordering == 1 %% no ordering -> SIC
        % ordering == 2 %% channel-gain based ordering -> OSIC (suboptimal ordering)
        % ordering == 3 %% SINR based ordering -> OSIC (optimal ordering - SINR based)        
        for ordering = 1:3        
            % ZF-SIC/OSIC
            receiver = receiver + 1;
            if simulating(receiver) == 1
                [detection_results] = Receiver_SIC_ZF(Tx, Rx, Rx_sym, ch, noise_va, symset, symset_mat, Q, ordering);        
                bit_result = bitset(detection_results,:);        
                bit_error(receiver) = bit_error(receiver) + sum(sum(abs(databits_mat - bit_result)));
            end

            % MMSE-SIC/OSIC
            receiver = receiver + 1;
            if simulating(receiver) == 1
                [detection_results] = Receiver_SIC_MMSE(Tx, Rx, Rx_sym, ch, noise_va, symset, symset_mat, Q, ordering);        
                bit_result = bitset(detection_results,:);        
                bit_error(receiver) = bit_error(receiver) + sum(sum(abs(databits_mat - bit_result)));
            end
        end
    

        if mod(tx_trial, 200) == 0 
            sprintf('SNR: %d dB, Number of Trials: %d, Number of Counted BIt Errors(min): %d/%d', SNR, tx_trial, min(bit_error(simulating)), bit_error_threshold)
            [BER; bit_error/(number_of_bits_per_transmission*tx_trial)]        
        end
    end  % FER While¹® END
    total_transmitted_bits = [total_transmitted_bits; number_of_bits_per_transmission*tx_trial];
    current_BER = bit_error/(number_of_bits_per_transmission*tx_trial);
    BER = [BER; current_BER];        
    
    simulating = ~(current_BER < BER_threshold);
    if sum(simulating) == 0
        break;
    end

    fileID = fopen('result.txt','a');
    fprintf(fileID, '%7.6e \t ', SNR);
    for i=1:number_of_tested_schemes
        fprintf(fileID, '%7.6e \t', current_BER(i));
    end
    fprintf(fileID, '\r\n');
    pause(0.1);
    fclose(fileID);
end % SNR for¹® END

simulated_SNR = Start_dB:dB_step:SNR;
%semilogy(simulated_SNR, BER);
%grid on;
colorVec = {'r', 'b', 'r', 'b', 'r', 'b', 'r', 'b'};
markVec = {'none', 'none', '^', '^', 's', 's', 'o', 'o'}; 
for i = 1:number_of_tested_schemes    
    semilogy(simulated_SNR, BER(:,i), 'Color',colorVec{i},'LineStyle','-', 'Marker', markVec{i},'LineWidth',0.5,'MarkerSize',6); hold on;
end
grid on;
title([num2str(Tx), ' X ', num2str(Rx), ' MIMO Systems']);
xlabel('SNR [dB]');
ylabel('Average BER');

fileID = fopen('result.txt','a');
end_time = sprintf('%s',datetime('now'));
fprintf(fileID, 'Simulaion End: %s\r\n\r\n\r\n', end_time);
pause(0.1);
fclose(fileID);