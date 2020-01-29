clc;
clear all;
close all;

message=randi([0,1],1,1000000);  %OK

QAM_16 = [];

QAM_16_symbol = zeros(1,length(message)/4);
temp = zeros(1, 4);
% symbol constellation(심벌 성상도)는 Notion에 올려놓았음 참고 바람(gray code 활용한 constellation임) % ====symbolization====
k = 1;

E_bN_0=-5:10;   %E_bN_0범위 지정
SNR = E_bN_0 + 10*log10(k); %Conversion into SNR


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
% 루트 10을 나누어야 신호 전력 S가 1이 됨.
QAM_16_symbol = QAM_16_symbol / sqrt(10);


% ====demodulation====  
for x_dB= 0:1:10
   error=0;  
   epoch=0;  
   error_count=0;
  
  
    while (error_count<=20)
        %S = (sum(QAM_16_symbol.^2)/16);
        S=1;
        N=S*10^(-0.1*x_dB);
        noise = sqrt(N/2)*randn(1,length(QAM_16_symbol)) + 1i*(sqrt(N/2)*randn(1,length(QAM_16_symbol)));      % 잡음 생성
        QAM_16_symbol_noise = QAM_16_symbol + noise;        %noise 추가
        
        QAM_16_symbol_demo = zeros(1, length(QAM_16_symbol_noise));
        
        % Deomodulation Symbol
        for i=1:1:length(QAM_16_symbol_noise)
            QAM_16_symbol_demo(1, i) = distance_measure(QAM_16_symbol_noise(1, i));
        end
        
        % Demodulation Symbol to bit
        QAM_16_bit_demo = demo_symbol_to_bit(QAM_16_symbol_demo);
        
        % error count, nnz, epoch plus 1
        error_bit = message - QAM_16_bit_demo;
        error = nnz(error_bit);       %error_bit 행렬에서 0이 아닌 원소의 개수를 센다 
        error_count = error_count + error;
        epoch = epoch + 1;
        
        
    end
     QAM_16 = [QAM_16 error_count/(epoch*length(message))];
end

% ====Graph====
% 1) BER-SNR 그래프
load ('BPSK_BER_measure_digital.mat','BPSK_BER');
x=0:1:10;
subplot(2,2,1);
semilogy(x,BPSK_BER);
load ('QPSK_BER_measure_digital.mat','QPSK_BER');
hold on;
semilogy(x,QPSK_BER);
hold on;
semilogy(x, QAM_16);

legend('BPSK','QPSK','QAM 16');

% 2) SER-SNR 그래프
load('QPSK_SER_measure_digital.mat','BPSK_SER');
x=0:1:10;
subplot(2,2,2);
semilogy(x,BPSK_SER);
load ('QPSK_SER_measure_digital.mat','QPSK_SER');
hold on;
semilogy(x,QPSK_SER);
hold on;
semilogy(x, QAM_16);
legend('QPSK','BPSK','QAM 16');

% wirte by 지연
% tber = berawgn(E_bN_0,'psk',2,'nondiff');   % Theoretical BER of BPSK in AWGN Channel 
% semilogy(E_bN_0,tber,'mx-','linewidth',2) %Plot Theoretical BER in AWGN
% hold on
% semilogy(E_bN_0,errrate,'b-','linewidth',2)  %Plot BER of Simulated Data
% axis([-6 11 10^-5 1])
% legend ('Theoratical BER','Simulation BER');
% xlabel('E_b/N_0 (dB)')
% ylabel('Bit Error Rate')
% title('BPSK Modulation in AWGN')
% grid on



% matlab에서 함수는 제일 밑에 써야 함(문법)

% 성상도에 따른 symbolization
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

% 거리 구하기, 심벌 복조용
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

% 심벌을 비트로 바꾸는 함수
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
