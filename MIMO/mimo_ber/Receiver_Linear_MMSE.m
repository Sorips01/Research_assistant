function [location] = Receiver_Linear_MMSE (Tx, ~,rx_sym, ch, noise_va, ~, symset_mat, Q)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

filter = (ch'*ch+noise_va*eye(Tx))\ch';
filtered_tx_symbol = filter*rx_sym;
normalized_filtered_tx_symbol = (filtered_tx_symbol./diag(filter*ch)).';
[~, location] = min(abs(symset_mat-(ones(Q,1)*normalized_filtered_tx_symbol).').');

end