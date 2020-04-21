# Research_assistant
JEoN-Ha 학부연구생(feat. 박상준 교수님)





# MIMO

![MIMO-antennas](_images\MIMO-antennas.PNG)
- **Multiple-Input and Multiple-Output**
- 다수의 송신 안테와 다수의 수신 안테나 시스템

## ZF (Zero Forcing)



# SISO

- **Single Input Single Output**
- 단일 송신 안테나, 단일 수신 안테나
- 안테나 diversity 효과 없음



## BPSK

- **디지털 신호(1,0)**에 따라 위상이 180˚ 다른 두 정현파로 변조하는 방식
![BPSK](_images\BPSK.JPG)



## QPSK

- 2진 PSK(BPSK) 방식과 달리, 위상을 90˚씩 변화함
- **4개 종류의 디지털 심볼(00, 01, 10, 11)**로 전송하는 4진 PSK 방식
![QPSK](_images\QPSK.JPG)



## 16QAM
![16QAM](_images\16QAM.PNG) <img src="_images\16QAM_1.PNG" alt="16QAM_1" title="16QAM 성상도&quot; &quot;width : 50px;height:50px" style="zoom:50%;" />

- QAM (Quadrature Amplitude Modulation)
- 한 심볼에 n bit 코딩 (16QAM은 1 symbol = 4 bits)



- 한 심볼에 전송할 수 있는 bit 수

  - BPSK : 1 bit
  - QPSK : 2 bits
  - 16 QAM : 4 bits
  - 64 QAM : 6 bits

  

## Rayleigh fading

- 신호가 많은 **물체와 빌딩사이에 가려 잘 도달하지 않고**, 주로 반사파들이 여러 다중 경로에 의해 수신측에 도달하여 합성하는데, 이때 신호 강도가 빠르게 요동치며 생기는 현상을 말한다.
- 건물이 많이 세워진 도심지에서 유용한 모델
![Rayleigh fading](_images\Rayleigh fading.PNG)



## BER

- Bit Error Ratio (비트 오류율)
  $$
  BER = \frac{수신된 비트 중 오류 비트 수}{송신한 총 비트 수}
  $$



## SER

- Symbol Error Ratio(심볼 오류율)



## SNR

- **신호 대 잡음 비** (Signal to noise ratio)
- SNR이 크다 = 잡음보다 신호의 power가 더 크다

$$
SNR = 10log\frac{v_s(rms)}{v_n(rms)} dB
$$



## Eb/N0

- 정의 : 디지털 통신의 성능평가 기준으로 **비트에너지 대 잡음전력 스펙트럼 밀도의 비**

$$
Eb = 비트시간 * 신호 전력 = Tb * S = (\frac{1}{비트전송률})*S = \frac{S}{Rb}
$$

$$
N0 = \frac{N}{W}
$$
![BER_vs_EbN0](_images\BER_vs_EbN0.PNG)



## BER/SER 과 SNR/EbN0 Graph 비교
![BERSER_graph](_images\BERSER_graph.PNG)



# SIMO

- **Single Input Multiple Output**
![SIMO](_images\SIMO.PNG)

## Diversity

- 송신, 수신측에 복수 개의 안테나(다중 안테나)를 설치하여 Diversity 효과를 얻는 방법
- 