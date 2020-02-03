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

 EbNo_dB = -3:1:20;
 EbNo = 10.^(EbNo_dB/10);
 
         
% %====demodulation====  
% for x_dB= 0:1:10
%    error_BER=0;  
%    epoch=0;  
%    error_count_BER=0;
%    error_count_SER=0;
%   
%     while (error_count_BER<=200)
%         S=2;                            %(sum(symbol.^2))/length(symbol)
%         N=S*10^(-0.1*x_dB);
%         noise =sqrt(N/2)*randn(1,length(symbol)) + 1i*(sqrt(N/2)*randn(1,length(symbol)));      % 잡음 생성
%         symbol_noise=symbol+noise;
%         symbol_demo = zeros(1,length(symbol_noise));
%      
%     
%      for j=1:1:length(symbol_noise) 
%                         
%         if(symbol_noise(j)<0 && imag(symbol_noise(j))<0)
%                symbol_demo(j) = -1-1i;
%          elseif(symbol_noise(j)<0 &&imag(symbol_noise(j))>0)
%                symbol_demo(j) = -1+1i;
%          elseif(symbol_noise(j)>0 &&imag(symbol_noise(j))<0)
%                symbol_demo(j) = 1-1i;
%          else
%                symbol_demo(j) = 1+1i;
%          end
%      end    
%     
%      error_symbol=symbol-symbol_demo;
%      error_SER=nnz(error_symbol);
%      error_count_SER = error_count_SER+error_SER;
%          
%          
%     bit_demo=zeros(1,length(message)); %복조한 심벌 비트로
%     k = 1;
%     for j=1:1:(length(symbol_demo))
%        if(symbol_demo(j) == -1-1i)
%            bit_demo(1,k) = 0;
%            k = k + 1;
%            bit_demo(1,k) = 0;
%            k = k + 1;
%        elseif(symbol_demo(j) == -1+1i)
%            bit_demo(1,k) = 0;
%            k = k + 1;
%            bit_demo(1,k) = 1;
%            k = k + 1;
%        elseif(symbol_demo(j) == 1-1i)
%            bit_demo(1,k) = 1;
%            k = k + 1;
%            bit_demo(1,k) = 0;
%            k = k + 1;   
%        else
%            bit_demo(1,k) = 1;
%            k = k + 1;
%            bit_demo(1,k) = 1;
%            k = k + 1;
%        end
%     end
%          error_bit=message-bit_demo;
%          error_BER=nnz(error_bit);       %error_bit 행렬에서 0이 아닌 원소의 개수를 센다 
%          error_count_BER = error_count_BER+error_BER;
%          epoch = epoch+1;
%         
%     end
%      QPSK_BER = [QPSK_BER error_count_BER/(epoch*length(message))];
%      QPSK_SER = [QPSK_SER error_count_SER/(epoch*length(message))];
% end
% 
   

QPSK_BER_EbNo=[];
QPSK_SER_EbNo=[];

for n = 1:length(EbNo_dB)

   error_BER_EbNo=0;  
   epoch_EbNo=0;  
   error_count_BER_EbNo=0;
   error_count_SER_EbNo=0;
   
    while (error_count_BER_EbNo<=200)
        S=2;  
        M = 2;                              %(sum(symbol.^2))/length(symbol)
        N=(1/M).*S.*10.^(-0.1.*EbNo_dB);
        noise =(1/sqrt(2.*EbNo(n))).*(randn(1,length(symbol)) + 1i.*(sqrt(N/2).*randn(1,length(symbol))));      % 잡음 생성
        symbol_noise_EbNo=symbol+noise;
        symbol_demo_EbNo = zeros(1,length(symbol_noise_EbNo));
     
    
     for j=1:1:length(symbol_noise_EbNo) 
                        
        if(symbol_noise_EbNo(j)<0 && imag(symbol_noise_EbNo(j))<0)
               symbol_demo_EbNo(j) = -1-1i;
         elseif(symbol_noise_EbNo(j)<0 &&imag(symbol_noise_EbNo(j))>0)
               symbol_demo_EbNo(j) = -1+1i;
         elseif(symbol_noise_EbNo(j)>0 &&imag(symbol_noise_EbNo(j))<0)
               symbol_demo_EbNo(j) = 1-1i;
         else
               symbol_demo_EbNo(j) = 1+1i;
         end
     end    
    
     error_symbol_EbNo=symbol-symbol_demo_EbNo;
     error_SER_EbNo=nnz(error_symbol);
     error_count_SER_EbNo = error_count_SER_EbNo+error_SER_EbNo;
         
         
    bit_demo_EbNo=zeros(1,length(message)); %복조한 심벌 비트로
    k = 1;
    for j=1:1:(length(symbol_demo_EbNo))
       if(symbol_demo_EbNo(j) == -1-1i)
           bit_demo_EbNo(1,k) = 0;
           k = k + 1;
           bit_demo_EbNo(1,k) = 0;
           k = k + 1;
       elseif(symbol_demo_EbNo(j) == -1+1i)
           bit_demo_EbNo(1,k) = 0;
           k = k + 1;
           bit_demo_EbNo(1,k) = 1;
           k = k + 1;
       elseif(symbol_demo_EbNo(j) == 1-1i)
           bit_demo_EbNo(1,k) = 1;
           k = k + 1;
           bit_demo_EbNo(1,k) = 0;
           k = k + 1;   
       else
           bit_demo_EbNo(1,k) = 1;
           k = k + 1;
           bit_demo_EbNo(1,k) = 1;
           k = k + 1;
       end
    end
         error_bit_EbNo=message-bit_demo_EbNo;
         error_BER_EbNo=nnz(error_bit_EbNo);       %error_bit 행렬에서 0이 아닌 원소의 개수를 센다 
         error_count_BER_EbNo = error_count_BER_EbNo+error_BER_EbNo;
         epoch = epoch+1;
        
    end

     QPSK_BER_EbNo = [QPSK_BER_EbNo error_count_BER_EbNo/(epoch_EbNo*length(message))];
     QPSK_SER_EbNo = [QPSK_SER_EbNo error_count_SER_EbNo/(epoch_EbNo*length(message))];
end


load ('BPSK_BER_measure_digital.mat','BPSK_BER');
x=0:1:10;         %그래프 그리기
semilogy(x,QPSK_BER);
hold on;
semilogy(x,BPSK_BER);

EbNo = -3:1:20;
semilogy(EbNo, QPSK_BER_EbNo);
hold on;

save QPSK_BER_measure_digital.mat QPSK_BER -v7.3
save QPSK_SER_measure_digital.mat QPSK_SER -v7.3


        