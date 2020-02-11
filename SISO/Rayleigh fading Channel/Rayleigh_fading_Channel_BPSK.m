%clc;
clear all;
close all;
tic

message=randi([0,1],1,1000000);
BPSK_BER=[];
BPSK_SER=[];

symbol=message;               %심볼화
for i = 1:1:length(message)
    if(message(1,i)==0)
        symbol(1,i)=symbol(1,i)-1;
    end
end

for x_dB= 0:5:40
    epoch=0;
    error=0;
    error_count_BER=0;
    error_count_SER=0;
    S=1;                            %(sum(symbol.^2))/length(symbol)
    N=S*10^(-0.1*x_dB);
    
    while error_count_BER<=1000
        noise =sqrt(N/2)*randn(1,length(symbol)) + 1i*(sqrt(N/2)*randn(1,length(symbol)));      %잡음 생성
        %noise = 0;
        h = sqrt(0.5) * [randn(1,length(symbol)) + 1i*randn(1,length(symbol))];       % Rayleigh channel
        h_c = conj(h);      % h 켤레복소수 생성
        symbol_h = symbol.*h;
        symbol_noise=symbol_h+noise;
        symbol_demo = zeros(1,length(symbol_noise));
        
        symbol_noise = symbol_noise .* h_c;
        symbol_noise = symbol_noise ./ (h .* h_c);
        
        for j=1:1:length(message)                   %수신 심벌 복조
            if(symbol_noise(1,j)>=0)
                symbol_demo(1,j) = 1;
            else
                symbol_demo(1,j)= -1;
            end
        end
        
        error_symbol = symbol - symbol_demo;
        error_SER = nnz(error_symbol);
        error_count_SER = error_count_SER + error_SER;
        
        symbol_bit=zeros(1,length(symbol_noise));                   %복조한 심벌 비트로
        for j=1:1:length(message)
            if(symbol_demo(1,j)==-1)
                symbol_bit(1,j)=0;
            else
                symbol_bit(1,j)=1;
            end
        end
        
        error_bit=message-symbol_bit;
        error_BER=nnz(error_bit);       %error_bit 행렬에서 0이 아닌 원소의 개수를 센다
        error_count_BER=error_count_BER+error_BER;
        epoch = epoch+1;
    end
    
    BPSK_BER = [BPSK_BER error_count_BER/(epoch*length(message))];
    BPSK_SER = [BPSK_SER error_count_SER/(epoch*length(message))];
end

% x=0:5:40;         %그래프 그리기
% subplot(2,1,1);
% semilogy(x,BPSK_BER);
% subplot(2,1,2);
% semilogy(x,BPSK_SER);



% 상위 폴더(Research_assistant)로 이동 -> mat_Rayleigh 폴더 이동 -> 저장
cd ..
cd mat_Rayleigh
save('BPSK_Rayleigh.mat', 'BPSK_BER', 'BPSK_SER', '-append');

% 상위 폴더(Research_assistant)로 이동 -> 'Rayleigh fading Channel' 폴더 이동
cd ..
cd 'Rayleigh fading Channel'

disp(mfilename('Class'))

toc