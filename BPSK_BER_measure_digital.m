clc;
clear all;
close all;

message = randi([0,1],1,100000);  %전송하는 메시지
symbol = message;

for i = 1:1:length(message)
    if message(i) == 0
        symbol(i) = message(i)-1;
    end  
end

BER = [];
for x = 0:1:10
   disp(x);
   error = 0;
   epoch = 0;                                                  % trial 횟수
   S = 1;                                                        %수식 첨부 
   N = S*10.^(-0.1*x);
   n = length(message);
   
   while(error < 200)
      noise = sqrt(N/2)*randn(1,n);           % white_gaussian_noise(mean = 0, var = N_0dB)
      receive = symbol + noise; %수신 심벌
      receive_bit = receive; 
      
      for i = 1:1:length(receive)
        if(receive(i) <0 )
            receive(i) = -1;
        else
            receive(i) = 1;
        end
      end
      
      for i = 1:1:length(message) 
          if(receive(i) > 0)
             receive_bit(i) = 1;
          else 
             receive_bit(i) = 0;
          end
      end
      
      for i = 1:1:length(message)
       if(message(i) - receive_bit(i) ~=0)
           error = error +1;
       end
      end
    epoch  = epoch+1;
   end
   disp(error);
  
   BER = [BER error/(epoch*length(message))];  %BER = 최종결과
    
end
x = 0:1:10;
figure
semilogy(x,BER)


