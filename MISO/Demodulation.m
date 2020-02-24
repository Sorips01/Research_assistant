function QPSK_BER = Demodulation(message, symbol,TX_count,type)
QPSK_BER = [];
%QPSK_SER = [];
for x_dB= 0:5:60

   error_BER=0;  
   epoch=0;  
   error_count_BER=0;
   error_count_SER=0;
  
    while (error_count_BER<=1000)
        S=2;                            %(sum(symbol.^2))/length(symbol)
        M=2;                            
        N=S*10^(-0.1*x_dB);
        Error_Limit = 1e-6;

        if(type == 1)
            symbol_noise = Channel_maker_MRT(N, TX_count, symbol);
        elseif(type == 2)
            symbol_noise = Channel_maker_Selection(N, TX_count, symbol);
        end

        symbol_demo = zeros(1,length(symbol_noise));
        
     for j=1:1:length(symbol_noise) 
                        
        if(real(symbol_noise(j))<0 && imag(symbol_noise(j))<0)
               symbol_demo(j) = -1-1i;
         elseif(real(symbol_noise(j))<0 && imag(symbol_noise(j))>0)
               symbol_demo(j) = -1+1i;
         elseif(real(symbol_noise(j))>0 && imag(symbol_noise(j))<0)
               symbol_demo(j) = 1-1i;
         else
               symbol_demo(j) = 1+1i;
         end
     end    
    
     error_symbol=symbol-symbol_demo;
     error_SER=nnz(error_symbol);
     error_count_SER = error_count_SER+error_SER;
         
         
    bit_demo=zeros(1,length(message)); 
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
         error_BER=nnz(error_bit);       
         error_count_BER = error_count_BER+error_BER;
         if  Error_Limit > error_count_BER/(epoch*length(message))
             break;
         end
         
         epoch = epoch+1;
        
    end
    
    if (type == 1)
        fprintf("Rx 개수 : %d / MRT / dB : %d / BER : %g \n", TX_count, x_dB,  error_count_BER/(epoch*length(message)));
    elseif (type == 2)
        fprintf("Rx 개수 : %d / Selection / dB : %d / BER : %g \n", TX_count, x_dB,  error_count_BER/(epoch*length(message)));
    end
    
    QPSK_BER = [QPSK_BER error_count_BER/(epoch*length(message))];
    %QPSK_SER = [QPSK_SER error_count_SER/(epoch*length(message))];
end
end