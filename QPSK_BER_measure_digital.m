clc;
clear all;
close all;

message=randi([0,1],1,100000);  %OK

BER=[];

symbol=zeros(1,length(message)/2);      

%====symbolization====    OK
k = 1;
for j = 1:2:(length(message)-2)

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
for x_dB= 0:1:10
   error=0;  
   epoch=0;  
   error_count=0;
  
    while (error_count<=20)
        S=1;                            %(sum(symbol.^2))/length(symbol)
        N=S*10^(-0.1*x_dB);
        noise =sqrt(N/2)*randn(1,length(symbol)) + 1i*(sqrt(N/2)*randn(1,length(symbol)));      % 잡음 생성
        symbol_noise=symbol+noise;
        symbol_demo = zeros(1,length(symbol_noise));
        k = 1;
    
     for j=1:1:length(symbol_noise) 
                        
        if(symbol_noise(j)<0 && imag(symbol_noise(j))<0)
               symbol_demo(k) = -1-1i;
               k = k+1;
         elseif(symbol_noise(j)<0 &&imag(symbol_noise(j))>0)
               symbol_demo(k) = -1+1i;
               k = k+1;
         elseif(symbol_noise(j)>0 &&imag(symbol_noise(j))<0)
               symbol_demo(k) = 1-1i;
               k = k+1;
         else
               symbol_demo(k) = 1+1i;
               k = k+1;
         end
     end    
    
    symbol_bit=zeros(1,0); %복조한 심벌 비트로
        
    for j=1:1:(length(symbol_demo))
           if(symbol_demo(j) == -1-1i)
               symbol_bit = [symbol_bit 0 0];
           elseif(symbol_demo(j) == -1+1i)
               symbol_bit = [symbol_bit 0 1];
           elseif(symbol_demo(j) == 1-1i)
               symbol_bit = [symbol_bit 1 0];
           else
               symbol_bit = [symbol_bit 1 1];
           end
    end
         error_bit=message-symbol_bit;
         error=nnz(error_bit);       %error_bit 행렬에서 0이 아닌 원소의 개수를 센다 
         error_count = error_count+error;
         epoch = epoch+1;
        
    end
     BER = [BER error_count/(epoch*length(message))]
end
    

x=0:1:10;         %그래프 그리기
semilogy(x,BER);


        