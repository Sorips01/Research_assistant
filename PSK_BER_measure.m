
% (1) Binary-PSK modulation

message=randi([0,1],1,10);                    % 랜덤하게 10개 Binary 숫자 생성
bit_period=.000001;
A=5;                                          % Amplitude of carrier signal 
bit_rate=1/bit_period;                        % bit rate
f=bit_rate*2;                                 % carrier frequency(왜 x2?)
t1=bit_period/99:bit_period/99:bit_period;    % 그래프를 그리기 위해 시간 간격 설정             
ss=length(t1);                                % ??

PSK=[];
for i=1:1:length(message)
    if (message(i)==1)
        y=A*cos(2*pi*f*t1);
    else
        y=A*cos(2*pi*f*t1+pi);   %A*cos(2*pi*f*t+pi) means -A*cos(2*pi*f*t)
    end
    PSK=[PSK y];                 
end

t2=bit_period/99:bit_period/99:bit_period*length(message);
subplot(3,1,2);
plot(t2,PSK); %psk한 후 개수 맞춰서 가우시안 잡음 생성하기
xlabel('time(sec)');
ylabel('amplitude(volt)');
title('waveform for binary PSK modulation coresponding binary information');

% (2) Gaussian_noise
noise_0dB = 0 + sqrt(N_0dB)*randn(1,n);           % white_gaussian_noise(mean = 0, var = N_0dB)
noise_20dB = 0 + sqrt(N_20dB)*randn(1,n);         % white_gaussian_noise(mean = 0, var = N_20dB)
noise_40dB = 0 + sqrt(N_40dB)*randn(1,n);         % white_gaussian_noise(mean = 0, var = N_40dB)

