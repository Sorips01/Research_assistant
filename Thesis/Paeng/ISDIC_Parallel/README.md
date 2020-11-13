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