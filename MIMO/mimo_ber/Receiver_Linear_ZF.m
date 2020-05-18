function [location] = Receiver_Linear_ZF(~, ~,rx_sym, ch, ~, ~, symset_mat, Q)

filter = (ch'*ch)\ch';
filtered_tx_symbol = filter*rx_sym; 
normalized_filtered_tx_symbol = (filtered_tx_symbol./diag(filter*ch)).'; 
[~, location] = min(abs(symset_mat-(ones(Q,1)*normalized_filtered_tx_symbol).').'); 

end