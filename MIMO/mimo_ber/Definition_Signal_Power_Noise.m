function [E_S, noise_va, noise_dv, No_ES, ES_No, noise_I_Rx, noise_I_Tx, symset_mat] = Definition_Signal_Power_Noise(SNR, Rx, Tx, symset)

E_S = 1;
% noise_va = Rx*E_S*10^(-SNR/10); %% RX normalized SNR
noise_va = E_S*10^(-SNR/10);
noise_dv = sqrt(0.5*noise_va);
No_ES = noise_va / E_S;
ES_No = E_S / noise_va;
noise_I_Rx = No_ES*eye(Rx);     
noise_I_Tx = No_ES*eye(Tx);
%%% Other Related Function %%%
symset2 = E_S * symset;
for i=1:Tx
    symset_mat(i,:) = symset2.';
end
    