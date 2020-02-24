function result = Channel_maker_Alamouti(N, Tx_count, Rx_count,symbol)
noise =sqrt(N/2)*(randn(Tx_count,Rx_count) + 1i*randn(Tx_count,Rx_count));      % Gaussian Noise
h = sqrt(0.5) * (randn(Tx_count,Rx_count) + 1i*randn(Tx_count,Rx_count));       % Rayleigh channel

symbol = [symbol; -conj(symbol(2)) conj(symbol(1))];

y = symbol*h + noise;
y = [y(1); conj(y(2))];
h_demo = [conj(h(1)) h(2); conj(h(2)) -h(1)];
symbol_noise = h_demo*y;
result = symbol_noise / sum(abs(h).^2);
% temp = h;
% for mrc = 1:1:TX_count-1
%     h = [h;temp];
% end
% 
% [~, index] = max(abs(h));
% h_SC = zeros(1,length(h));
% for i = 1:1:length(symbol)
%     h_SC(1,i) = h(index(1,i),i);              % select h
% end
% 
% [~, index] = max(abs(noise));
% noise_SC = zeros(1,length(noise));
% for i = 1:1:length(symbol)
%     noise_SC(1,i) = noise(index(1,i),i);        % select noise
% end
% 
% h_c = conj(h_SC);      % h_rms_max�� �ӷ����Ҽ� ����
% symbol_h = symbol.*h_SC;   % hx
% symbol_noise = symbol_h + noise_SC;    % hx + n
% 
% 
% symbol_noise = symbol_noise .* h_c;
% symbol_noise = symbol_noise ./ (h_SC .* h_c);
% result = symbol_noise;
end