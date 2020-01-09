
% (1) Binary-PSK modulation
disp(' start');
message=randi([0,1],1,100);                    % 랜덤하게 10개 Binary 숫자 생성
disp(' message : ');
disp(message);

bit_period=.000001;
A=5;                                          % Amplitude of carrier signal 
bit_rate=1/bit_period;                        % bit rate
f=bit_rate*2;                                 % carrier frequency(왜 x2?)                               
t1=bit_period/1000:bit_period/1000:bit_period;    % 그래프를 그리기 위해 시간 간격 설정             
ss=length(t1); 

PSK=[];
for i=1:1:length(message)
    if (message(i)==1)
        y=A*cos(2*pi*f*t1);
    else
        y=A*cos(2*pi*f*t1+pi);   %A*cos(2*pi*f*t+pi) means -A*cos(2*pi*f*t)
    end
    PSK=[PSK y];                 
end

t2=bit_period/1000:bit_period/1000:bit_period*length(message);
subplot(3,1,1);
plot(t2,PSK);
xlabel('time(sec)');
ylabel('amplitude(volt)');
title('waveform for binary PSK modulation coresponding binary information');

% (2) Gaussian_noise
% noise_0dB = 0 + sqrt(N_0dB)*randn(1,n);           % white_gaussian_noise(mean = 0, var = N_0dB)
% noise_20dB = 0 + sqrt(N_20dB)*randn(1,n);         % white_gaussian_noise(mean = 0, var = N_20dB)
% noise_40dB = 0 + sqrt(N_40dB)*randn(1,n);         % white_gaussian_noise(mean = 0, var = N_40dB)

% (3) A combination of noise and modulation
noise =0.2*rand(1,100000);      % 잡음 생성
PSK_noise = PSK + noise;     % PSK 변조에 잡음 추가
subplot(3,1,2);
plot(t2,PSK_noise);
title('waveform for binary PSK modulation and noise');

% (4) Binary PSK demodulation
PSK_demodulation=[];
for n=ss:ss:length(PSK_noise)
  t3=bit_period/1000:bit_period/1000:bit_period;
  y=cos(2*pi*f*t3);                                        % carrier signal 
  section=y.*PSK_noise((n-(ss-1)):n); % n번째 구간 지정
  integration = trapz(t3,section);                         % 사다리꼴 적분 
  value=round((2*integration/bit_period));                                     
  if(value>0)                                     % logic level = (A+A)/2=0 
                         %becouse A*cos(2*pi*f*t+pi) means -A*cos(2*pi*f*t)
    a=1;
  else
    a=0;
  end
  PSK_demodulation=[PSK_demodulation a];
end
disp(' Binary information at Reciver :');
disp(PSK_demodulation);

% (5) BER 측정
count=0;
for i=1:1:length(message)
    if(message(1,i) ~= PSK_demodulation(1,i)) % 복조한 값이 다르면 에러 발생
        count=count+1;
    end
end
BER=count/length(message);
disp(' BER :');
disp(BER);


