function [location] = Receiver_SIC_ZF(Tx, ~, rx_sym, ch, ~, symset, ~, ~, ordering)

rx_sym_buf = rx_sym;
ch_buf = ch;     

% ordering == 1 %% no ordering -> SIC
% ordering == 2 %% channel-gain based ordering -> OSIC

location = zeros(Tx,1);
mapping_vector = 1:Tx;
for i=1:Tx
    current_Tx = Tx + 1 -i;
    ch_product = ch_buf'*ch_buf;
    filter = ch_product\ch_buf';
    if ordering == 1
        value_for_ordering = current_Tx:-1:1;
    elseif ordering == 2
        value_for_ordering = diag(real(ch_product));    % diag : 대각 행렬을 생성하거나 행렬의 대각선 요소 가져오기
    elseif ordering == 3
        value_for_ordering = 1./diag(real(inv(ch_product)));
    end
    [~, selected_symbol_location] = max(value_for_ordering);
    normalization_value = diag(real(filter(selected_symbol_location,:)*ch_buf(:,selected_symbol_location)));
    normalized_detected_symbol = (filter(selected_symbol_location,:)*rx_sym_buf)/normalization_value;
    [~, location(mapping_vector(selected_symbol_location))] = min(abs(symset - normalized_detected_symbol));  
    if current_Tx > 1
        IC_symbol = symset(location(mapping_vector(selected_symbol_location)));    
        rx_sym_buf = rx_sym_buf - ch_buf(:,selected_symbol_location)*IC_symbol;
        ch_buf(:, selected_symbol_location) = [];
        mapping_vector(:, selected_symbol_location) = [];
    end
end


end
