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
for x_dB= -3:1:12

   error_BER=0;  
   epoch=0;  
   error_count_BER=0;
   error_count_SER=0;
  
    while (error_count_BER<=200)
        S=2;                            %(sum(symbol.^2))/length(symbol)
        M=2;                            % symbolï¿½ï¿½ ï¿½ï¿½Æ® ï¿½ï¿½
        N=S*10^(-0.1*x_dB)*(1/M);

        noise =sqrt(N/2)*randn(1,length(symbol)) + 1i*(sqrt(N/2)*randn(1,length(symbol)));      %ÀâÀ½ »ý¼º
        h = sqrt(0.5) * [randn(1,length(symbol)) + 1i*randn(1,length(symbol))];       % Rayleigh channel
        h_c = conj(h);      % h ÄÓ·¹º¹¼Ò¼ö »ý¼º
        symbol_h = symbol.*h;
        symbol_noise=symbol_h+noise;
        symbol_demo = zeros(1,length(symbol_noise));
        
        symbol_noise = symbol_noise .* h_c;
        symbol_noise = symbol_noise ./ (h .* h_c);
    
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
         
         
    bit_demo=zeros(1,length(message)); %ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½É¹ï¿½ ï¿½ï¿½Æ®ï¿½ï¿½
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
         error_BER=nnz(error_bit);       %error_bit ï¿½ï¿½Ä¿ï¿½ï¿½ï¿? 0ï¿½ï¿½ ï¿½Æ´ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ 
         error_count_BER = error_count_BER+error_BER;
         epoch = epoch+1;
        
    end
     QPSK_BER = [QPSK_BER error_count_BER/(epoch*length(message))];
     QPSK_SER = [QPSK_SER error_count_SER/(epoch*length(message))];
end


x=-3:1:12;         %±×·¡ÇÁ ±×¸®±â
axis([-3 12 0 10^-5]);
subplot(2,1,1);
semilogy(x,QPSK_BER);
subplot(2,1,2);
semilogy(x,QPSK_SER);



        