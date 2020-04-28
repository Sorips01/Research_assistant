function [result] = ZF_Modulation(r, h)
%h = (randn(Rx,Tx) + 1j * randn(Rx,Tx))/sqrt(2);
%noise = (randn(Rx,1) + 1j * randn(Rx,1)) * sqrt(N/2);
% h_Hermitian = inv(conj(h.') * h) * conj(h.');
h_Hermitian = (conj(h.') * h) \ conj(h.');
%r = h * symbol + noise;
result = h_Hermitian * r;
end

