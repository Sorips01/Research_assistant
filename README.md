
Research_assistant

# Research_assistant
[TOC]



# MISO



## Maximal -Ratio Transmission(MRT)

- **SIMO의 MRC와 동일한 원리-->동일성능**
  
- 차이점) 채널 정보를 송신단에서 알고 있어야 함. 
  
- 송신 Power를 더 쓰지 않도록 각 송신 안테나 신호에 대한 Power Normalization이 필요

  

  ![](_images\MISO_MRC.JPG)




$$
Transmitt Power: 
\left|\frac{|h_1^H*x}{a}\right|^2 +\left|\frac{|h_1^H*x}{a}\right|^2 =\frac{\left|H_1\right|^2*\left|x\right|^2}{\left|H_1\right|^2+\left|H_2\right|^2} +\frac{\left|H_2\right|^2*\left|x\right|^2}{\left|H_1\right|^2+\left|H_2\right|^2}  = \left|x\right|^2
$$



## Selection

-  MISO 시스템에서 Transmit Diversity를 달성하기 위한 송신 방법 중 하나 

-  SIMO의 SC와 동일한 원리 

-  동일한 성능 

-  SISO 환경과 동일한 신호 파워로 전송

  

![](_images\MISO_Selection.JPG)


$$
Transmitt Power = \left|x\right|^2
$$






## Alamouti STBC

##### pre) 

##### 	MRT (Maximal-Ratio Transmission) / Antenna Selection 

-  MISO System을 위한 Diversity 달성 기법 
-  송신단에서 채널 정보를 알아야만 사용 가능한 기술들 
   -  MRT : 정확한 채널 값 
   -  Antenna Selection: 어떤 안테나의 채널이 더 좋은지 
      -  수신단에서부터 송신단으로의 피드백이 기본적으로 필요



#### Alamouti STBC

___




![](_images\MISO_Alamouti1.JPG)



- 각 시간마다 한 TX Antenna만을 사용하여 Diversity를 확보하는 방법
  -  본 기법: 0.5 심볼 전송 / 시간, 채널 정보 필요 X (MISO)	
  -  MRT: 1 심볼 전송 / 시간, 채널 정보 필요 O (MISO) 
  -  MRC: 1 심볼 전송 / 시간, 채널 정보 필요 X (SIMO) 



![](_images\MISO_Alamouti2.JPG)



- *Alamouti STBC – Equivalent System Model*

  


$$
\begin{bmatrix} y_1 \\ y_2^* \end{bmatrix} = \begin{bmatrix} h_1&h_2\\ h_2^*& -h_1^* \end{bmatrix}\begin{bmatrix} y_1 \\ y_2^* \end{bmatrix} +\begin{bmatrix} n_1 \\ n_2^* \end{bmatrix}
$$

- *Detection for the 1st TX symbol*

  

$$
h_1^*y_1 + h_2y_2^*= \left|h_1\right|^2 + h_1^*h_2x_2 + \left|h_2\right|^2x_1 - h_2h_1^*x_2 + noise = \left|h_1\right|^2x_1 + \left|h_2\right|^2x_1 =noise
$$



- *Detection for the 2nd TX symbol*

  

  $$
  h_2^*y_1 + h_1y_2^*=  h_2^*h_1x_1 + \left|h_2\right|^2x_2 - h_1h_2^*x_1+ \left|h_1\right|^2x_2 + noise = \left|h_1\right|^2x_2 + \left|h_2\right|^2x_2 +noise
  $$

  

- Alamouti STBC in MISO Systems (2x1)

  -   두 개의 신호를 두 번의 시간 동안 전송함

  -   두 전송 신호에 대해 두개의 채널(Diversity)을 보장하며, 또한 상호간 간섭 없는 신호를 추출할 수 있는 간단한 복호과정을 가짐 

  -   Alamouti STBC: 1 심볼 전송 / 시간, 채널 정보 필요 X (MISO 2x1)

  -   Simple STBC: 0.5 심볼 전송 / 시간, 채널 정보 필요 X (MISO) 

  -   MRT: 1 심볼 전송 / 시간, 채널 정보 필요 O (MISO) 

  -   MRC: 1 심볼 전송 / 시간, 채널 정보 필요 X (SIMO) 

    

- 상기 기법들은 2x1 MISO / 1x2 SIMO를 가정할 때 모두 2개의 독립 적인 채널을 통한 Diversity 획득

  

- Alamouti STBC의 제약 사항 

  -  MISO 시스템 중에서는 2x1 환경에만 적용 가능
  -  두 전송 시간동안 채널이 변하지 않아야 최대 성능 보장. 
     -  채널이 변화할 경우 간섭 성분이 남을 수 있음






# MIMO



![MIMO-antennas](_images\MIMO-antennas.PNG)
- **Multiple-Input and Multiple-Output**
- 다수의 송신 안테와 다수의 수신 안테나 시스템

## ZF (Zero Forcing)




# SISO

- **Single Input Single Output**
- 단일 송신 안테나, 단일 수신 안테나
- 안테나 diversity 효과 없음

-  MISO 시스템에서 Transmit Diversity를 달성하기 위한 송신 방법 중 하나 

-  SIMO의 SC와 동일한 원리 

-  동일한 성능 

-  SISO 환경과 동일한 신호 파워로 전송

  

![](_images\MISO_Selection.JPG)

Transmitt Power:
$$
\left|x\right|^2
$$






## BPSK




![](_images\MISO_Alamouti1.JPG)



- 각 시간마다 한 TX Antenna만을 사용하여 Diversity를 확보하는 방 법
  -  본 기법: 0.5 심볼 전송 / 시간, 채널 정보 필요 X (MISO)	
  -  MRT: 1 심볼 전송 / 시간, 채널 정보 필요 O (MISO) 
  -  MRC: 1 심볼 전송 / 시간, 채널 정보 필요 X (SIMO) 



![](_images\MISO_Alamouti2.JPG)



- *Alamouti STBC – Equivalent System Model*


$$
\begin{bmatrix} y_1 \\ y_2^* \end{bmatrix} = \begin{bmatrix} h_1&h_2\\ h_2^*& -h_1^* \end{bmatrix}\begin{bmatrix} y_1 \\ y_2^* \end{bmatrix} +\begin{bmatrix} n_1 \\ n_2^* \end{bmatrix}
$$

- *Detection for the 1st TX symbol*

  

$$
h_1^*y_1 + h_2y_2^*= \left|h_1\right|^2 + h_1^*h_2x_2 + \left|h_2\right|^2x_1 - h_2h_1^*x_2 + noise = \left|h_1\right|^2x_1 + \left|h_2\right|^2x_1 =noise
$$



- *Detection for the 2nd TX symbol*

  
  $$
  h_2^*y_1 + h_1y_2^*=  h_2^*h_1x_1 + \left|h_2\right|^2x_2 - h_1h_2^*x_1+ \left|h_1\right|^2x_2 + noise = \left|h_1\right|^2x_2 + \left|h_2\right|^2x_2 +noise
  $$
  
- Alamouti STBC in MISO Systems (2x1)

  -   두 개의 신호를 두 번의 시간 동안 전송함

  -   두 전송 신호에 대해 두개의 채널(Diversity)을 보장하며, 또한 상호간 간섭 없는 신호를 추출할 수 있는 간단한 복호과정을 가짐 

  - Alamouti STBC: 1 심볼 전송 / 시간, 채널 정보 필요 X (MISO 2x1)

  -  Simple STBC: 0.5 심볼 전송 / 시간, 채널 정보 필요 X (MISO) 

  -  MRT: 1 심볼 전송 / 시간, 채널 정보 필요 O (MISO) 

  -  MRC: 1 심볼 전송 / 시간, 채널 정보 필요 X (SIMO) 

    

- 상기 기법들은 2x1 MISO / 1x2 SIMO를 가정할 때 모두 2개의 독립 적인 채널을 통한 Diversity 획득

  

-  Alamouti STBC의 제약 사항 

  -  MISO 시스템 중에서는 2x1 환경에만 적용 가능
  - 두 전송 시간동안 채널이 변하지 않아야 최대 성능 보장. 
    -  채널이 변화할 경우 간섭 성분이 남을 수 있음



- **디지털 신호(1,0)**에 따라 위상이 180˚ 다른 두 정현파로 변조하는 방식
![BPSK](_images\BPSK.JPG)




## QPSK

- 2진 PSK(BPSK) 방식과 달리, 위상을 90˚씩 변화함
- **4개 종류의 디지털 심볼(00, 01, 10, 11)**로 전송하는 4진 PSK 방식
![QPSK](_images\QPSK.JPG)








## ZF (Zero Forcing)

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