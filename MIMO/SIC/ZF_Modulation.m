function [result] = ZF_Modulation(h,noise,symbol)

% h = (randn(Rx,Tx) + 1j * randn(Rx,Tx))/sqrt(2);

% h_Hermitian = inv(conj(h.') * h) * conj(h.');
h_Hermitian = (conj(h.') * h) \ conj(h.');
r = h * symbol + noise;
result = h_Hermitian * r;

end

