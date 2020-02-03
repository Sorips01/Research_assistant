clc;
clear all;
close all;

message=randi([0,1],1,1000000);  %OK

QAM_16_BER = [];
QAM_16_SER = [];

QAM_16_symbol = zeros(1,length(message)/4);
temp = zeros(1, 4);
% symbol constellation(ï¿½É¹ï¿½ ï¿½ï¿½ï¿½ï¿½)ï¿½ï¿½ Notionï¿½ï¿½ ï¿½Ã·ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ù¶ï¿½(gray code È°ï¿½ï¿½ï¿½ï¿½ constellationï¿½ï¿½) % ====symbolization====
k = 1;

% ====symbolization====  
for i=1:1:length(message)
    temp(1, k) = message(1, i);
    if k == 4
        k = 1;
        QAM_16_symbol(1, i/4) = binary_to_complex_number(temp);
    else
        k = k + 1;
    end
end
% ï¿½ï¿½Æ® 10ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿? ï¿½ï¿½È£ ï¿½ï¿½ï¿½ï¿½ Sï¿½ï¿½ 1ï¿½ï¿½ ï¿½ï¿½.
QAM_16_symbol = QAM_16_symbol / sqrt(10);


% ====demodulation====  
for x_dB= -3:1:15
   error_BER=0;  
   epoch=0;  
   error_count_BER=0;
   error_count_SER=0;

    while (error_count_BER<=200)
        %S = (sum(QAM_16_symbol.^2)/16);
        S=1;
        M = 4; % symbol ´ç bit ¼ö 
        N=S*10^(-0.1*x_dB) * (1/M);
        noise = sqrt(N/2)*randn(1,length(QAM_16_symbol)) + 1i*(sqrt(N/2)*randn(1,length(QAM_16_symbol)));      % ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½
        QAM_16_symbol_noise = QAM_16_symbol + noise;        %noise ï¿½ß°ï¿½
        
        QAM_16_symbol_demo = zeros(1, length(QAM_16_symbol_noise));
        
        % Deomodulation Symbol
        for i=1:1:length(QAM_16_symbol_noise)
            QAM_16_symbol_demo(1, i) = distance_measure(QAM_16_symbol_noise(1, i));
        end
        
        % SER ï¿½ï¿½ï¿½ï¿½
        error_bit_SER = QAM_16_symbol - QAM_16_symbol_demo;
        error_SER = nnz(error_bit_SER);       
        error_count_SER = error_count_SER + error_SER;
        
        % Demodulation Symbol to bit
        QAM_16_bit_demo = demo_symbol_to_bit(QAM_16_symbol_demo);
        
        % BER ï¿½ï¿½ï¿½ï¿½ : error count, nnz, epoch plus 1
        error_bit_BER = message - QAM_16_bit_demo;
        error_BER = nnz(error_bit_BER);       %error_bit ï¿½ï¿½Ä¿ï¿½ï¿½ï¿? 0ï¿½ï¿½ ï¿½Æ´ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ 
        error_count_BER = error_count_BER + error_BER;
        epoch = epoch + 1;
        
        
    end
     QAM_16_BER = [QAM_16_BER error_count_BER/(epoch*length(message))];
     QAM_16_SER = [QAM_16_SER error_count_SER/(epoch*length(message))];
end
% 
%   E_bN_0dB=0:1:10;   %E_bN_0 = 0dB
%   E_bN_0 = 10^(E_bN_0dB/10); %dB°ªÀ¸·Î E_bN_0°è»ê
%   SNR = E_bN_0*2; %Rb/b = 2(°¡Á¤)

disp("finish")
% % ====Graph====
% % 1) BER-SNR ï¿½×·ï¿½ï¿½ï¿½
% load ('BPSK_BER_measure_digital.mat','BPSK_BER');
% x=-3:1:20;
% graph1 = subplot(2,2,1);
% 
% semilogy(x,BPSK_BER);
% load ('QPSK_BER_measure_digital.mat','QPSK_BER');
% hold on;
% semilogy(x,QPSK_BER);
% hold on;
% semilogy(x, QAM_16_BER);
% title('BER-SNR Graph ---->');
% ylabel(graph1,'BER ---->');
% xlabel(graph1, 'SNR ---->');
% legend('BPSK','QPSK','QAM 16');
% 
% % 2) SER-SNR ï¿½×·ï¿½ï¿½ï¿½
% load('BPSK_SER_measure_digital.mat','BPSK_SER');
% x=0:1:10;
% graph2 = subplot(2,2,2);
% semilogy(x,BPSK_SER);
% load ('QPSK_SER_measure_digital.mat','QPSK_SER');
% hold on;
% semilogy(x,QPSK_SER);
% hold on;
% semilogy(x, QAM_16_SER);
% title('SER-SNR Graph ---->');
% ylabel(graph2,'SER ---->');
% xlabel(graph2, 'SNR ---->');
% legend('BPSK','QPSK','QAM 16');
% 
% %EbN0 graph
% subplot(2,2,1);
% plot(EbNo_noise(k),'r.');
% % wirte by ï¿½ï¿½ï¿½ï¿½
% % tber = berawgn(E_bN_0,'psk',2,'nondiff');   % Theoretical BER of BPSK in AWGN Channel 
% % semilogy(E_bN_0,tber,'mx-','linewidth',2) %Plot Theoretical BER in AWGN
% % hold on
% % semilogy(E_bN_0,errrate,'b-','linewidth',2)  %Plot BER of Simulated Data
% % axis([-6 11 10^-5 1])
% % legend ('Theoratical BER','Simulation BER');
% % xlabel('E_b/N_0 (dB)')
% % ylabel('Bit Error Rate')
% % title('BPSK Modulation in AWGN')
% % grid on


% matlabï¿½ï¿½ï¿½ï¿½ ï¿½Ô¼ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½Ø¿ï¿½ ï¿½ï¿½ï¿? ï¿½ï¿½(ï¿½ï¿½ï¿½ï¿½)

% ï¿½ï¿½ï¿½óµµ¿ï¿½ ï¿½ï¿½ï¿½ï¿½ symbolization
function comp_number = binary_to_complex_number(binary)
comp = ones(1, 4);
if binary(1) == 0
    comp(1) = binary(1) - 1;
end

if binary(2) == 0
    comp(2) = 3;
end

if binary(3) == 0
    comp(3) = 1;
else
    comp(3) = -1;
end

if binary(4) == 0
    comp(4) = 3;
end

comp_number = (comp(1) * comp(2)) + (comp(3) * comp(4) * 1i);
end

% ï¿½Å¸ï¿½ ï¿½ï¿½ï¿½Ï±ï¿½, ï¿½É¹ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½
function symbol_demo = distance_measure(symbol)
point = [-3+3i -3+1i -3-1i -3-3i -1+3i -1+1i -1-1i -1-3i 1+3i 1+1i 1-1i 1-3i 3+3i 3+1i 3-1i 3-3i];
point = point / sqrt(10);

symbol_real = real(symbol);
symbol_imag = imag(symbol);

point_to_point = zeros(1, length(point));

for i=1:1:length(point)
    point_to_point(1, i) = sqrt((symbol_real - real(point(1, i)))^2 + (symbol_imag - imag(point(1, i)))^2); %sqrt((symbol_real - real(point(1, i))).^2 + (symbol_imag - imag(point(1, i))).^2);
end

distance = min(point_to_point);
[x, y] = find(point_to_point == distance);
symbol_demo = point(1, y);
end

% ï¿½É¹ï¿½ï¿½ï¿½ ï¿½ï¿½Æ®ï¿½ï¿½ ï¿½Ù²Ù´ï¿½ ï¿½Ô¼ï¿½
function bit_demo = demo_symbol_to_bit(symbol)
symbol_real = real(symbol);
symbol_imag = imag(symbol);

bit_demo = zeros(1, length(symbol)*4);
k = 1;
for i=1:4:(length(symbol)*4)
    if symbol_real(1, k) < 0
        bit_demo(1, i) = 0;
    else
        bit_demo(1, i) = 1;
    end

    if abs(symbol_real(1, k)) > (2/sqrt(10))
        bit_demo(1, i + 1) = 0;
    else
        bit_demo(1, i + 1) = 1;
    end

    if symbol_imag(1, k) > 0
        bit_demo(1, i + 2) = 0;
    else
        bit_demo(1, i + 2) = 1;
    end

    if abs(symbol_imag(1, k)) > (2/sqrt(10))
        bit_demo(1, i + 3) = 0;
    else
        bit_demo(1, i + 3) = 1;
    end
    k = k + 1;
end

end
