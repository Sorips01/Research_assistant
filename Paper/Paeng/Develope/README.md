# Overview
ISDIC-MMSE 기법의 성능 향상을 목적으로 한 연구
## You should know
- QPSK
- Rayleigh fading
- BER
- MMSE
- SIC
- OSIC

# SISO

- **Single Input Single Output**
- 단일 송신 안테나, 단일 수신 안테나
- 안테나 diversity 효과 없음

-  MISO 시스템에서 Transmit Diversity를 달성하기 위한 송신 방법 중 하나 

-  SIMO의 SC와 동일한 원리 

-  동일한 성능 

-  SISO 환경과 동일한 신호 파워로 전송
## QPSK

- 2진 PSK(BPSK) 방식과 달리, 위상을 90˚씩 변화함
- **4개 종류의 디지털 심볼(00, 01, 10, 11)**로 전송하는 4진 PSK 방식


![QPSK](./_img/QPSK.PNG)
## Rayleigh fading

- 신호가 많은 **물체와 빌딩사이에 가려 잘 도달하지 않고**, 주로 반사파들이 여러 다중 경로에 의해 수신측에 도달하여 합성하는데, 이때 신호 강도가 빠르게 요동치며 생기는 현상을 말한다.
- 건물이 많이 세워진 도심지에서 유용한 모델


![Rayleigh fading](./_img/Rayleigh_fading.PNG)




## BER

- Bit Error Ratio (비트 오류율)<br>
  ![BER](./_img
/BER.PNG)
# MIMO

![MIMO-antennas](./_img/MIMO-antennas.PNG)
- **Multiple-Input and Multiple-Output**
- 다수의 송신 안테와 다수의 수신 안테나 시스템
- Spatially multiplexing (공간 다중화) 개념과 Spatial Diversity (공간 다이버시티) 개념이 포함됨

<img src="https://latex.codecogs.com/gif.latex?y%20%3D%20Hx%20&plus;%20n">

보통 MIMO System Model은 N개의 TX, M개의 RX를 가진다.

- y : M x 1 receive signal vector
- H : M x N **MIMO** channel matrix
- x : N x 1 transmitted signal vector
- n : M x 1 AWGN (Additive white Gaussian noise) vector



## ZF (Zero-Forcing)

### ZF Filter

<img src="https://latex.codecogs.com/gif.latex?G_%7BZF%7D%20%3D%20%5Cbegin%7Bcases%7D%20H%5E%7B-1%7D%5Cquad%5Cquad%5Cquad%5Cquad%5Cquad%5Cquad%5Cquad%5Cquad%20M%20%3D%20N%20%5C%5C%20H%5E%7B%5Cdagger%7D%20%3D%20%28H%5EH%20H%29%5E%7B-1%7DH%5EH%20%5Cquad%5C%2C%5C%2C%20M%3EN%20%5Cend%7Bcases%7D">


### Output of the ZF receiver
<img src="https://latex.codecogs.com/gif.latex?G_%7BZF%7D%20%5C%2C%5C%2C%20y%20%3D%20%5Cbegin%7Bcases%7D%20H%5E%7B-1%7D%28Hx%20&plus;%20n%29%20%3D%20x%20&plus;%20H%5E%7B-1%7Dn%5Cquad%5Cquad%5Cquad%5Cquad%5Cquad%5Cquad%5Cquad%5Cquad%5Cquad%5C%2C%5C%2C%20M%20%3D%20N%20%5C%5C%20%28H%5EH%20H%29%5E%7B-1%7DH%5EH%28Hx%20&plus;%20n%29%20%3D%20x%20&plus;%20%28H%5EH%20H%29%5E%7B-1%7DH%5EHn%20%5Cquad%5C%2C%5C%2C%20M%3EN%20%5Cend%7Bcases%7D">


- M < N 인 시스템에서는 사용할 수 없다.
- Diversity order가 ![m_n+1](./_img/m_n+1.PNG)이다.
- Linear receivers 이다.

송수신 수식에서 H를 이용해 H의 **에르미트 행렬**을 구하고 이를 이용해 **ZF Filter**를 구한다. <br>

구한 **ZF Filter**를 수식에 곱하여 수신 심벌 x + N(이외의 수) 꼴로 보상해준다.



## MMSE (Minimum Mean Square Error)

![MMSE](./_img/MMSE.PNG)

<img src="https://latex.codecogs.com/gif.latex?%5Cbegin%7Bmatrix%7D%20G_%7BMMSE%7D%20%26%3D%26%20H%5EH%28HH%5EH%20&plus;%20%5Csigma_n%5E2%20I%29%5E%7B-1%7D%5C%5C%20%26%3D%26%28H%5EHH%20&plus;%20%5Csigma_n%5E2%20I%29%5E%7B-1%7D%20H%5EH%20%5Cend%7Bmatrix%7D">

- 여기서 ![sigma_square](./_img/sigma_square.PNG)는 잡음 전력의 분산의 제곱이다.
- M < N 인 시스템에서는 사용할 수 없다.
- Diversity order 는 ![m_n+1](./_img/m_n+1.PNG) 로  ZF 와 같다.
- Error Performance는 ZF 보다 좋다.
- Linear receivers 이다.



## ML (Maximum-likelihood)

![arg_min](./_img/arg_min.PNG)를 만족하는 X를 찾는 알고리즘이다. 

즉, x에 들어갈 수 있는 모든 조합을 구하여 H를 곱한 후, 수신 심벌 y에서 뺀 값이 최소인 x가 Demodulation한 값이 된다. 

![ML](./_img/ML.PNG)

- Optimal performance를 가지고 있다. (즉 최적화가 잘 되어 있다.)
- 하지만 복잡하고 연산 시 시간이 많이 필요하다.
- Non-Linear receivers 이다.



### Diversity order 비교 (ZF, MMSE, ML)

![diversityOrder](./_img/diversityOrder.PNG)

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

![sic-example_1](./_img/sic-example_1.PNG) 
![sic-example_2](./_img/sic-example_2.PNG)
![sic-example_3](./_img/sic-example_3.PNG)

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
![OSIC_receiver](./_img/OSIC_receiver.PNG)



###  Diversity order 비교 (Normal, SIC, OSIC)

![diversity-OSIC](./_img/diversity-OSIC.PNG)


# OSIC-MMSE or ISDIC-MMSE
Orderd SIC(Succesive Interference Cancellation)

MMSE 기반의 반복 연판정 간섭 제거 기법

## 기법
1) 연판정 벡터 ![eq](https://latex.codecogs.com/gif.latex?%5Cinline%20s%20%3D%20%5Bs_1%2C%20...%20%2C%20%7Bs%7D_%7BN_T%7D%5D%5ET) 의 원소들을 모두 0으로, 잔여 간섭분산 벡터 ![eq](https://latex.codecogs.com/gif.latex?%5Cinline%20v%20%3D%20%5Bv_1%2C%20...%20%2C%20%7Bv%7D_%7BN_T%7D%5D%5ET)의 원소들을 모두 1로, k를 1로 초기화한다.
2) k번째 Iteration에서 의 심볼 검출 순서를 정한다.
   1) 검출 순서는 조건(ex. 전력을 가장많이 가지고 있는 순서)을 어떻게 두느냐에 따라 다르다.
   2) 이때 ![eq](https://latex.codecogs.com/gif.latex?%5Cinline%20O_k%28n%29%20%3D%20i)라면 k번째 Iteration에서 ![eq](https://latex.codecogs.com/gif.latex?%5Cinline%20S_i)가 n번째 순서임을 나타낸다.
3) ![eq](https://latex.codecogs.com/gif.latex?%5Cinline%20n%20%3D%201%2C...%2CN_T)까지 다음 과정을 수행한다.
   1) 연판정 간섭 제거 신호 벡터 r, MMSE 검출 벡터 f를 계산한다.
   2) ![eq](https://latex.codecogs.com/gif.latex?%5Cinline%20r_%7Bk%2Ci%7D%20%3D%20r%20-%20%5Csum_%7Bj%3D1%2C%20j%20%5Cneq%20i%7D%5E%7BN_T%7D%20h_j%20s_j)
   3) ![eq](https://latex.codecogs.com/gif.latex?%5Cinline%20f_%7Bk%2Ci%7D%20%3D%20%7Bh_i%7D%5EH%20%28HD_%7Bk%2Ci%7D%20H%5EH%20&plus;%20%5Csigma%5E2%20I_%7BN_R%7D%29%5E-1)
4) D는 i번째 주대각 원소 1을 제외하고 n번째 주대각 원소가 ![eq](https://latex.codecogs.com/gif.latex?%5Cinline%20v_n)인 ![eq](https://latex.codecogs.com/gif.latex?%5Cinline%20N_T%20%5Ctimes%20N_T) 대각행렬이며, ![eq](https://latex.codecogs.com/gif.latex?%5Cinline%20I_%7BN_R%7D)은 ![eq](https://latex.codecogs.com/gif.latex?%5Cinline%20N_T%20%5Ctimes%20N_T) 항등행렬이다. ![eq](https://latex.codecogs.com/gif.latex?%5Cinline%20b_%7Bk%2Ci%7D%20%3D%20f_%7Bk%2Ci%7D%20h_i)일 때, s,v는 r,f를 통해 갱신된다.
   1) ![eq](https://latex.codecogs.com/gif.latex?%5Cinline%20p_%7Bk%2Ci%2Cq%7D%20%3D%20exp%28-%7Cf_%7Bk%2Ci%7Dr_%7Bk%2Ci%7D%20-%20a_q%20b_%7Bk%2Ci%7D%7C%5E2%20/%20%5Bb_%7Bk%2Ci%7D%281%20-%20b_%7Bk%2Ci%7D%29%5D%29)
   2) ![eq](https://latex.codecogs.com/gif.latex?%5Cinline%20s_i%20%3D%20%28%5Csum_%7Bq%3D1%7D%5E%7BQ%7Da_q%20p_%7Bk%2Ci%2Cq%7D%29%20/%20%28%5Csum_%7Bq%3D1%7D%5E%7BQ%7Dp_%7Bk%2Ci%2Cq%7D%29)
   3) ![eq](https://latex.codecogs.com/gif.latex?%5Cinline%20v_i%20%3D%20%28%5Csum_%7Bq%3D1%7D%5E%7BQ%7D%7Ca_q%20-%20s_i%7C%5E2%20p_%7Bk%2Ci%2Cq%7D%29%20/%20%28%5Csum_%7Bq%3D1%7D%5E%7BQ%7Dp_%7Bk%2Ci%2Cq%7D%29)