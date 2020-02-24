function result = Noise_maker_Selection(N, TX_count, symbol)
noise =sqrt(N/2)*randn(TX_count,length(symbol)) + 1i*(sqrt(N/2)*randn(TX_count,length(symbol)));      %���� ����
%h = sqrt(0.5) * [randn(RX_count,length(symbol)) + 1i*randn(RX_count,length(symbol))];       % Rayleigh channel
h = sqrt(0.5) * [randn(TX_count,length(symbol)) + 1i*randn(TX_count,length(symbol))];       % Rayleigh channel

[~, index] = max(abs(h));
h_Selected = zeros(1,length(h));

for i = 1:1:length(symbol)
    h_Selected(1,i) = h(index(1,i),i);              % select h
end

[~, index] = max(abs(noise));
noise_Selected = zeros(1,length(noise));

for i = 1:1:length(symbol)
    noise_Selected(1,i) = noise(index(1,i),i);        % select noise
end

h_c = conj(h_Selected);      % h_rms_max�� �ӷ����Ҽ� ����
symbol_h = symbol.*h_Selected;   % hx
symbol_noise = symbol_h + noise_Selected;    % hx + n


symbol_noise = symbol_noise .* h_c;
symbol_noise = symbol_noise ./ (h_Selected .* h_c);
result = symbol_noise;
end