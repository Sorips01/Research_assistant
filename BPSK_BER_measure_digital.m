clc;
clear all;

message=randi([0,1],1,1000000);
count=0;
BER=[];
symbol=message;               %심볼화
for i = 1:1:length(message)
    if(message(1,i)==0)
        symbol(1,i)=-1;
    end
end

for x_dB= 0:1:10
    epoch=0;
    error=0;
    error_count=0;
    
    while error_count<=200
        S=(sum(symbol.^2))/length(symbol);
        N=S*10^(-0.1*x_dB);
        noise =sqrt(N/2)*randn(1,length(symbol));      % 잡음 생성
        symbol_noise=symbol+noise;
        symbol_demo = symbol_noise;
        
        for j=1:1:length(message)                   %수신 심벌 복조
            if(symbol_noise(1,j)>=0)
                symbol_demo(1,j) = 1;
            else
                symbol_demo(1,j)= -1;
            end
        end
        
        symbol_bit=symbol_demo;                   %복조한 심벌 비트로
        for j=1:1:length(message)
            if(symbol_demo(1,j)==-1)
                symbol_bit(1,j)=0;
            end
        end
        
        error_bit=message-symbol_bit;
        error=nnz(error_bit);       %error_bit 행렬에서 0이 아닌 원소의 개수를 센다
        error_count=error_count+error;
        epoch = epoch+1;
    end
    
    BER= [BER error_count/(epoch*length(message))];
end


        