function [result] = ML_Modulation(Tx, Rx, N, symbol)
h = (randn(Rx,Tx) + 1j * randn(Rx,Tx))/sqrt(2);
noise = (randn(Rx,1) + 1j * randn(Rx,1)) * sqrt(N/2);

r = h * symbol + noise;
result = r;
end

