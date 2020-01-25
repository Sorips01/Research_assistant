clc;
clear all;
close all;

message=randi([0,1],1,1000000);  %OK

QAM_16 = [];

QAM_16_symbol = zeros(1,length(message)/4);
temp = zeros(1, 4);
% symbol constellation(심벌 성상도)는 Notion에 올려놓았음 참고 바람(gray code 활용한 constellation임) % ====symbolization====
D_value = [0 0 0];        % Decimal_value
k = 1;

for i=1:1:length(message)
    temp(k) = message(i);
    if k == 4
        k = 1;
        QAM_16_symbol(i/4) = binary_to_complex_number(temp)    
    else
        k = k + 1;
    end
end



====demodulation====  
for x_dB= 0:1:10
   error=0;  
   epoch=0;  
   error_count=0;
  
    while (error_count<=200)
        S=2;                            %(sum(symbol.^2))/16
        N=S*10^(-0.1*x_dB);
        noise =sqrt(N/2)*randn(1,length(symbol)) + 1i*(sqrt(N/2)*randn(1,length(symbol)));      % 잡음 생성

        % error count, nnz, epoch plus 1
        error_bit=message-bit_demo;
        error=nnz(error_bit);       %error_bit 행렬에서 0이 아닌 원소의 개수를 센다 
        error_count = error_count+error;
        epoch = epoch+1;
        
    end
     QAM_16 = [QAM_16 error_count/(epoch*length(message))];
end

x=0:1:10;         %그래프 그리기
semilogy(x, QAM_16);


% matlab에서 함수는 제일 밑에 써야 함(문법)

function comp_number = binary_to_complex_number(binary)
comp = zeros(1, 4);
if binary(1) == 0
    comp(1) = binary(1) - 1;
end

if binary(2) == 0
    comp(2) = 3
end

if binary(3) == 0
    comp(3) = binary(3) - 1;
end

if binary(4) == 0
    comp(4) = 3
end

comp_number = (comp(1) * comp(2)) + (comp(3) * comp(4) * 1i);

end

% 이진수를 십진수로(Binary to Decimal) 바꾸는 함수
function [first second decimal] = binary_to_decimal(binary)
decimal = 0;
for i = 1:1:length(binary)
    decimal = decimal + (binary(i) * 2^(length(binary) - i));       % 0(2^3)+1(2^2)+1(2^1)+1(2^0) = 7
end
first = binary(1);
second = binary(2);
decimal = decimal - (first * 8) - (second * 4);

if binary(2) == 0

end

function symbol_value = symbolization(d_value)
if d_value(1) == 
    symbol
    
end

end

