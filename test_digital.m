clc;
clear all;
close all;

message=randi([0,1],1,1000000);  %OK

QAM_16 = [];

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