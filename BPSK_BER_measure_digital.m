clc;
clear all;
close all;

message = randi([0,1],1,100000);  %전송하는 메시지

for i = 1:1:length(message)
    if message[i] == 1
        symbol(i) = 1;
    else
        symbol(i) = 0;
        
    end  
end

epoch = 0; % trial 횟수
error = 0;
for x = 0:1:10
    
   
   while(error == 200)
      noise_xdB = sqrt(N/2)*randn(1,n);           % white_gaussian_noise(mean = 0, var = N_0dB)
      receive = symbol + noise_xdB; %수신 심벌 
      for i = 1:1:length(message) 
          if(receive(i) > 0)
             receive_bit(i) = 1;
          else 
             receive_bit(i) = 0;
          end
      end
      epoch  = epoch+1;
   end
   for i = 1:1:length(message)
       if(message(i) ~= receive_bit(i))
           error ++;
       end
   end
  
end
 BER = error/(epoch*length(message))  %BER = 최종결과
