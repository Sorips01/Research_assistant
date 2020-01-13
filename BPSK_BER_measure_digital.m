clc;
clear all;
close all;


message = randi([0,1],1,100000);  %전송하는 메시지
bit[length(message)];
for i = 1:1:length(message)
    if message[i] == 1
        bit[i] = 1;
    else
        bit[i] = 0;
        
    end  
end


for x = 0:1:10
    epoch = 0; % trial 횟수
    error = 0;
    
   while(error == 200)
      noise_xdB = sqrt(N/2)*randn(1,n);           % white_gaussian_noise(mean = 0, var = N_0dB)
      receive = symbol + noise_xdB; %수신 심벌 
      i = 1:1:length(message) 
      if(receive > 0)
            receive_bit[i] = 1;
            i = i+1
        else 
            receive_bit[i] = 0;
            i = i+1
        end
       epoch  = epoch+1
   end
   
end
BER = error/(epoch*length(message))  %BER = 최종결과
