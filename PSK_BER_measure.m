% 이건 test용 파일이다 빠끄
t = 0:1:100
message=randi([0,1],1,10);
bit_period=.000001;
A=5;                                          % Amplitude of carrier signal 
bit_rate=1/bp;                                % bit rate
f=bit_rate*2;                                 % carrier frequency 
t2=bit_period/99:bit_period/99:bit_period;                 
ss=length(t2);
m=[];
for i=1:1:length(message)
    if (message(i)==1)
        y=A*cos(2*pi*f*t2);
    else
        y=A*cos(2*pi*f*t2+pi);   %A*cos(2*pi*f*t+pi) means -A*cos(2*pi*f*t)
    end
    m=[m y];
end
t3=bit_period/99:bit_period/99:bit_period*length(x);
subplot(3,1,2);
plot(t3,m); %psk한 후 개수 맞춰서 가우시안 잡음 생성하기
xlabel('time(sec)');
ylabel('amplitude(volt)');
title('waveform for binary PSK modulation coresponding binary information');

%Gaussian_noise
noise_0dB = 0 + sqrt(N_0dB)*randn(1,n);           % white_gaussian_noise(mean = 0, var = N_0dB)
noise_20dB = 0 + sqrt(N_20dB)*randn(1,n);         % white_gaussian_noise(mean = 0, var = N_20dB)
noise_40dB = 0 + sqrt(N_40dB)*randn(1,n);         % white_gaussian_noise(mean = 0, var = N_40dB)