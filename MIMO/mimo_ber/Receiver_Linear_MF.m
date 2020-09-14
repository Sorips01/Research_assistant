function [location] = Receiver_Linear_MF(~, ~,rx_sym, ch, ~, ~, symset_mat, Q)

filter = ch';
filtered_tx_symbol = filter*rx_sym; %% filtered symbol is modled as y = ax + b
normalized_filtered_tx_symbol = (filtered_tx_symbol./diag(filter*ch)).'; %% normalization with the gain 'a' in the above
[~, location] = min(abs(symset_mat-(ones(Q,1)*normalized_filtered_tx_symbol).').'); %% find the symbol with the minimum distance

end