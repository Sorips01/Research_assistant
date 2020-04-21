
Research_assistant

# Research_assistant


# SISO

- **Single Input Single Output**
- 단일 송신 안테나, 단일 수신 안테나
- 안테나 diversity 효과 없음

-  MISO 시스템에서 Transmit Diversity를 달성하기 위한 송신 방법 중 하나 

-  SIMO의 SC와 동일한 원리 

-  동일한 성능 

-  SISO 환경과 동일한 신호 파워로 전송




![](./_images/MISO_Selection.JPG)

Transmitt Power: 

$$$ \left|x\right|^2 $$$<br>
<img src="https://latex.codecogs.com/gif.latex?\left|x\right|^2" title="\left|x\right|^2" />







## BPSK





![](./_images/MISO_Alamouti1.JPG)



- 각 시간마다 한 TX Antenna만을 사용하여 Diversity를 확보하는 방 법
  -  본 기법: 0.5 심볼 전송 / 시간, 채널 정보 필요 X (MISO)	
  -  MRT: 1 심볼 전송 / 시간, 채널 정보 필요 O (MISO) 
  -  MRC: 1 심볼 전송 / 시간, 채널 정보 필요 X (SIMO) 



![](./_images/MISO_Alamouti2.JPG)



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


![BPSK](./_images/BPSK.JPG)




## QPSK

- 2진 PSK(BPSK) 방식과 달리, 위상을 90˚씩 변화함
- **4개 종류의 디지털 심볼(00, 01, 10, 11)**로 전송하는 4진 PSK 방식


![QPSK](./_images/QPSK.JPG)







## 16QAM
![16QAM](./_images/16QAM.PNG) <img src="_images\16QAM_1.PNG" alt="16QAM_1" title="16QAM 성상도&quot; &quot;width : 50px;height:50px" style="zoom:50%;" />


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
![Rayleigh fading](./_images\Rayleigh fading.PNG)



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
![BER_vs_EbN0](./_images/BER_vs_EbN0.PNG)



## BER/SER 과 SNR/EbN0 Graph 비교
![BERSER_graph](./_images/BERSER_graph.PNG)





___

___



# SIMO

- **Single Input Multiple Output**
![SIMO](./_images/SIMO.PNG)

## Diversity

- 송신, 수신측에 복수 개의 안테나(다중 안테나)를 설치하여 Diversity 효과를 얻는 방법







___

___




# MISO



## Maximal -Ratio Transmission(MRT)

- **SIMO의 MRC와 동일한 원리-->동일성능**
  
- 차이점) 채널 정보를 송신단에서 알고 있어야 함. 
  
- 송신 Power를 더 쓰지 않도록 각 송신 안테나 신호에 대한 Power Normalization이 필요

  

  ![](./_images/MISO_MRC.JPG)




$$
Transmitt Power: 
\left|\frac{|h_1^H*x}{a}\right|^2 +\left|\frac{|h_1^H*x}{a}\right|^2 =\frac{\left|H_1\right|^2*\left|x\right|^2}{\left|H_1\right|^2+\left|H_2\right|^2} +\frac{\left|H_2\right|^2*\left|x\right|^2}{\left|H_1\right|^2+\left|H_2\right|^2}  = \left|x\right|^2
$$



## Selection

-  MISO 시스템에서 Transmit Diversity를 달성하기 위한 송신 방법 중 하나 

-  SIMO의 SC와 동일한 원리 

-  동일한 성능 

-  SISO 환경과 동일한 신호 파워로 전송

  

![](./_images/MISO_Selection.JPG)


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




![](./_images/MISO_Alamouti1.JPG)



- 각 시간마다 한 TX Antenna만을 사용하여 Diversity를 확보하는 방법
  -  본 기법: 0.5 심볼 전송 / 시간, 채널 정보 필요 X (MISO)	
  -  MRT: 1 심볼 전송 / 시간, 채널 정보 필요 O (MISO) 
  -  MRC: 1 심볼 전송 / 시간, 채널 정보 필요 X (SIMO) 



![](./_images/MISO_Alamouti2.JPG)



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
     
     

___

___

# MIMO

![MIMO-antennas](./_images/MIMO-antennas.PNG)
- **Multiple-Input and Multiple-Output**
- 다수의 송신 안테와 다수의 수신 안테나 시스템
- Spatially multiplexing (공간 다중화) 개념과 Spatial Diversity (공간 다이버시티) 개념이 포함됨


$$
y = Hx + n
$$

보통 MIMO System Model은 N개의 TX, M개의 RX를 가진다.

- y : M x 1 receive signal vector
- H : M x N **MIMO** channel matrix
- x : N x 1 transmitted signal vector
- n : M x 1 AWGN (Additive white Gaussian noise) vector



## ZF (Zero-Forcing)

### ZF Filter

$$
G_{ZF} = 
\begin{cases}
H^{-1}\quad\quad\quad\quad\quad\quad\quad\quad	M = N
\\
H^{\dagger} = (H^H H)^{-1}H^H \quad\,\, M>N
\end{cases}
$$

### Output of the ZF receiver

$$
G_{ZF} \,\, y = 
\begin{cases}
H^{-1}(Hx + n) = x + H^{-1}n\quad\quad\quad\quad\quad\quad\quad\quad\quad\,\,	M = N
\\
(H^H H)^{-1}H^H(Hx + n) = x + (H^H H)^{-1}H^Hn \quad\,\, M>N
\end{cases}
$$

- M < N 인 시스템에서는 사용할 수 없다.
- Diversity order가 $$ M-N+1$$ 이다.
- Linear receivers 이다.

송수신 수식에서 H를 이용해 H의 **에르미트 행렬**을 구하고 이를 이용해 **ZF Filter**를 구한다. <br>

구한 **ZF Filter**를 수식에 곱하여 수신 심벌 x + N(이외의 수) 꼴로 보상해준다.



## MMSE (Minimum Mean Square Error)

![MMSE](./_images/MMSE.PNG)

$$
\begin{matrix}
G_{MMSE} &=& H^H(HH^H + \sigma_n^2 I)^{-1}\\
		&=&(H^HH + \sigma_n^2 I)^{-1} H^H
\end{matrix}
$$

- 여기서 $$ \sigma_n^2$$는 잡음 전력의 분산의 제곱이다.
- M < N 인 시스템에서는 사용할 수 없다.
- Diversity order 는 $$ M-N+1$$ 로  ZF 와 같다.
- Error Performance는 ZF 보다 좋다.
- Linear receivers 이다.



## ML (Maximum-likelihood)

$$\arg{(min (\rVert y-Hx' \rVert^2))}$$ 를 만족하는 X를 찾는 알고리즘이다. 

즉, $$x$$에 들어갈 수 있는 모든 조합을 구하여 $$H$$를 곱한 후, 수신 심벌 $$y$$에서 뺀 값이 최소인 $$x$$가 Demodulation한 값이 된다. 

![ML](./_images/ML.PNG)

- Optimal performance를 가지고 있다. (즉 최적화가 잘 되어 있다.)
- 하지만 복잡하고 연산 시 시간이 많이 필요하다.
- Non-Linear receivers 이다.



### Diversity order 비교 (ZF, MMSE, ML)

![diversityOrder](./_images/diversityOrder.PNG)

## SIC (Successive Interference Cancellation)

- **Based on the Linear Receiver (MMSE, ZF)**
- **Serial IC** 라고도 부른다.
- 자료에 있는 설명
  - First, Estimate ont of TX symbols using Linear Filter
  - Second, Cancel it from the RX vectors, as if the TX symbol was no actually transmitted -> Go to First
- 해석
  1. 선행 필터(MMSE, ZF)를 통해 송신부에서 온 symbol을 복조한다.
  2. 수신부에 섞인 간섭을 제거하여 다시 선행 필터를 통해 필터링한다. 아직 남은 송신 심벌이 남아 있다면 1.번을 반복한다.



### Example

![sic-example_1](./_images/sic-example_1.PNG) 
![sic-example_2](./_images/sic-example_2.PNG)
![sic-example_3](./_images/sic-example_3.PNG)

- ZF, MMSE 기법만 사용한 것 보다 성능이 좋다.
- ZF, MMSE 보다 복잡도가 증가된다.
- 하지만 ML 보다는 복잡도가 낮다.
- 주의점 Error Propagation(오류 전파)
  - 첫 심벌이 오류가 일어난 것이었다면 이 오류성은 후에 일어나는 일련의 과정들 모두에게 전파된다. 따라서 오류가 커질 수도 있다.



## OSIC (Ordered Successive Interference Cancellation)

- To minimize the occurence of error propagations in SIC
- SIC에서 Error Propagation을 최소화 하기 위해 고안된 방법
- TX에서 보낸 심벌의 SNR을 측정하여, 최대인 것을 SIC 연산식에서 우선순위를 둔다.(먼저 뺀다)
- SNR이 최대라는 것은 송신 및 수신과정에서 오류가 일어났을 확률이 최소이기 때문에, 우선순위를 둔다. 이에 따라 오류가 일어날 확률이 큰, 즉 SNR이 제일 작은 송신 심벌은 간섭이 제거되기 때문에 전체적으로 오류의 확률이 적어지게 된다.
- SNR을 구하기(구현과정이) 힘들기 때문에 행렬 $$H$$에서 열 순서로 $$h1, h2, h3, ...$$ 중 크기가 가장 큰 것으로 우선순위를 두어도 크게 상관은 없다. (정확한 OSIC는 아니지만, 연산 결과도 크게 차이나지 않는다.)



### SNR 구하는 과정 (어려움)
![OSIC_receiver](./_images/OSIC_receiver.PNG)



###  Diversity order 비교 (Normal, SIC, OSIC)

![diversity-OSIC](./_images/diversity-OSIC.PNG)
