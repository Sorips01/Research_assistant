clc;
clear all;
close all;

message=randi([0,1],1,1000000);  %OK

QPSK_BER=[];
QPSK_SER=[];

symbol=zeros(1,length(message)/2);      

%====symbolization====    OK
k = 1;
for j = 1:2:(length(message)-1)

    if(message(j) == 0 && message(j+1) == 0)
       symbol(k) = -1-1i;
       k = k+1;
    elseif(message(j) == 0 && message(j+1) == 1)
       symbol(k) = -1+1i;
       k = k+1;
    elseif(message(j) == 1 && message(j+1) == 0)
       symbol(k) = 1-1i;
       k = k+1;
    else
      symbol(k) = 1+1i;
      k = k+1;
    end
    
end
         
%====demodulation====  
for x_dB= -3:1:12;
    
   error_BER=0;  
   epoch=0;  
   error_count_BER=0;
   error_count_SER=0;
  
    while (error_count_BER<=200)
        S=2;               %(sum(symbol.^2))/length(symbol)
        M = 2;
        N=(1/M)*S*10^(-0.1*x_dB);
        noise =sqrt(N/2)*randn(1,length(symbol)) + 1i*(sqrt(N/2)*randn(1,length(symbol)));      % 잡음 생성
        symbol_noise=symbol+noise;
        symbol_demo = zeros(1,length(symbol_noise));
     
    
     for j=1:1:length(symbol_noise) 
                        
        if(symbol_noise(j)<0 && imag(symbol_noise(j))<0)
               symbol_demo(j) = -1-1i;
         elseif(symbol_noise(j)<0 &&imag(symbol_noise(j))>0)
               symbol_demo(j) = -1+1i;
         elseif(symbol_noise(j)>0 &&imag(symbol_noise(j))<0)
               symbol_demo(j) = 1-1i;
         else
               symbol_demo(j) = 1+1i;
         end
     end    
    
     error_symbol=symbol-symbol_demo;
     error_SER=nnz(error_symbol);
     error_count_SER = error_count_SER+error_SER;
         
         
    bit_demo=zeros(1,length(message)); %복조한 심벌 비트로
    k = 1;
    for j=1:1:(length(symbol_demo))
       if(symbol_demo(j) == -1-1i)
           bit_demo(1,k) = 0;
           k = k + 1;
           bit_demo(1,k) = 0;
           k = k + 1;
       elseif(symbol_demo(j) == -1+1i)
           bit_demo(1,k) = 0;
           k = k + 1;
           bit_demo(1,k) = 1;
           k = k + 1;
       elseif(symbol_demo(j) == 1-1i)
           bit_demo(1,k) = 1;
           k = k + 1;
           bit_demo(1,k) = 0;
           k = k + 1;   
       else
           bit_demo(1,k) = 1;
           k = k + 1;
           bit_demo(1,k) = 1;
           k = k + 1;
       end
    end
         error_bit=message-bit_demo;
         error_BER=nnz(error_bit);       %error_bit 행렬에서 0이 아닌 원소의 개수를 센다 
         error_count_BER = error_count_BER+error_BER;
         epoch = epoch+1;
        
    end
     QPSK_BER = [QPSK_BER error_count_BER/(epoch*length(message))];
     QPSK_SER = [QPSK_SER error_count_SER/(epoch*length(message))];
end

   
load ('BPSK_BER_measure_digital.mat','BPSK_BER');
x=-3:1:15;         %그래프 그리기
semilogy(x,QPSK_BER);
hold on;
semilogy(x,BPSK_BER);


save QPSK_BER_measure_digital.mat QPSK_BER -v7.3
save QPSK_SER_measure_digital.mat QPSK_SER -v7.3


        