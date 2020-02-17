%clc;
clearvars;
close all;
tic
format shortE;
message=randi([0,1],1,1000000);  %OK

QPSK_BER_MRC=[];
QPSK_BER_EGC=[];
QPSK_BER_SC=[];

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
RX_count = 2;

QPSK_BER_MRC = [QPSK_BER_MRC; Demodulation(message, symbol, RX_count, 1)];
QPSK_BER_EGC = [QPSK_BER_EGC; Demodulation(message, symbol, RX_count, 2)];
QPSK_BER_SC = [QPSK_BER_SC; Demodulation(message, symbol, RX_count, 3)];

RX_count = 3;
QPSK_BER_MRC = [QPSK_BER_MRC; Demodulation(message, symbol, RX_count, 1)];
QPSK_BER_EGC = [QPSK_BER_EGC; Demodulation(message, symbol, RX_count, 2)];
QPSK_BER_SC = [QPSK_BER_SC; Demodulation(message, symbol, RX_count, 3)];


RX_count = 4;
QPSK_BER_MRC = [QPSK_BER_MRC; Demodulation(message, symbol, RX_count, 1)];
QPSK_BER_EGC = [QPSK_BER_EGC; Demodulation(message, symbol, RX_count, 2)];
QPSK_BER_SC = [QPSK_BER_SC; Demodulation(message, symbol, RX_count, 3)];


toc


cd mat_Rayleigh_fading_SIMO
save('QPSK_Rayleigh_SIMO.mat', 'QPSK_BER_MRC', 'QPSK_BER_EGC', 'QPSK_BER_SC', '-append');

cd ..


disp(mfilename('Class'))



function result = Noise_maker_MRC(N, RX_count, symbol)
noise =sqrt(N/2)*randn(RX_count,length(symbol)) + 1i*(sqrt(N/2)*randn(RX_count,length(symbol)));      %ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½
h = sqrt(0.5) * [randn(RX_count,length(symbol)) + 1i*randn(RX_count,length(symbol))];       % Rayleigh channel

h_c = conj(h); 

symbol_h = symbol.*h; % h ï¿½Ó·ï¿½ï¿½ï¿½ï¿½Ò¼ï¿½ ï¿½ï¿½ï¿½ï¿½
symbol_noise=symbol_h+noise;


%symbol_noise = zeros(1,length(symbol));

symbol_noise = symbol_noise .*h_c;
symbol_noise = sum(symbol_noise);
%h_square = zeros(1,length(h));

h_square = h.*h_c;
symbol_noise = symbol_noise ./ sum(abs(h_square));

result = symbol_noise;
end

function result = Noise_maker_EGC(N, RX_count, symbol)
noise =sqrt(N/2)*randn(RX_count,length(symbol)) + 1i*(sqrt(N/2)*randn(RX_count,length(symbol)));      %ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½
h = sqrt(0.5) * [randn(RX_count,length(symbol)) + 1i*randn(RX_count,length(symbol))];       % Rayleigh channel

h_c = conj(h);      % h ï¿½Ó·ï¿½ï¿½ï¿½ï¿½Ò¼ï¿½ ï¿½ï¿½ï¿½ï¿½

symbol_h = symbol.*h;
symbol_noise=symbol_h+noise;


symbol_noise = symbol_noise .* h_c;
symbol_noise = symbol_noise ./ abs(h_c);
symbol_noise = sum(symbol_noise);
%symbol_noise = symbol_noise ./ sum(abs(h));

result = symbol_noise;
end


function result = Noise_maker_SC(N, RX_count, symbol)
noise =sqrt(N/2)*randn(RX_count,length(symbol)) + 1i*(sqrt(N/2)*randn(RX_count,length(symbol)));      %ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½
h = sqrt(0.5) * [randn(RX_count,length(symbol)) + 1i*randn(RX_count,length(symbol))];       % Rayleigh channel

[value index] = max(abs(h));
h_SC = zeros(1,length(h));
for i = 1:1:length(symbol)
    h_SC(1,i) = h(index(1,i),i);              % select h
end

[value index] = max(abs(noise));
noise_SC = zeros(1,length(noise));
for i = 1:1:length(symbol)
    noise_SC(1,i) = noise(index(1,i),i);        % select noise
end

h_c = conj(h_SC);      % h_rms_maxï¿½ï¿½ ï¿½Ó·ï¿½ï¿½ï¿½ï¿½Ò¼ï¿½ ï¿½ï¿½ï¿½ï¿½
symbol_h = symbol.*h_SC;   % hx
symbol_noise = symbol_h + noise_SC;    % hx + n


symbol_noise = symbol_noise .* h_c;
symbol_noise = symbol_noise ./ (h_SC .* h_c);
result = symbol_noise;
end


function QPSK_BER = Demodulation(message, symbol,RX_count,type)
QPSK_BER = [];
%QPSK_SER = [];
for x_dB= 0:5:60

   error_BER=0;  
   epoch=0;  
   error_count_BER=0;
   error_count_SER=0;
  
    while (error_count_BER<=1000)
        S=2;                            %(sum(symbol.^2))/length(symbol)
        %M=2;                            % symbolï¿½ï¿½ ï¿½ï¿½Æ® ï¿½ï¿½
        N=S*10^(-0.1*x_dB);
        Error_Limit = 1e-6;

        if(type == 1)
            symbol_noise = Noise_maker_MRC(N, RX_count, symbol);
        elseif(type == 2)
            symbol_noise = Noise_maker_EGC(N, RX_count, symbol);
        elseif(type == 3)
            symbol_noise = Noise_maker_SC(N, RX_count, symbol);
        end

        
        
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
         error_BER=nnz(error_bit);       %error_bit ï¿½ï¿½Ä¿ï¿½ï¿½ï¿??? 0ï¿½ï¿½ ï¿½Æ´ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ 
         error_count_BER = error_count_BER+error_BER;
         if  Error_Limit > error_count_BER/(epoch*length(message))
             break;
         end
         
         epoch = epoch+1;
        
    end
    
    if (type == 1)
        fprintf("Rx °³¼ö : %d / MRC / dB : %d / BER : %f \n", RX_count, x_dB,  error_count_BER/(epoch*length(message)));
    elseif (type == 2)
        fprintf("Rx °³¼ö : %d / EGC / dB : %d / BER : %f \n", RX_count, x_dB,  error_count_BER/(epoch*length(message)));
    elseif (type == 3)
        fprintf("Rx °³¼ö : %d / SC / dB : %d / BER : %f \n", RX_count, x_dB,  error_count_BER/(epoch*length(message)));
    end
    
    QPSK_BER = [QPSK_BER error_count_BER/(epoch*length(message))];
    %QPSK_SER = [QPSK_SER error_count_SER/(epoch*length(message))];
end
end

        