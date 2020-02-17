function result = Noise_maker_SC(N, RX_count, symbol)
noise =sqrt(N/2)*randn(RX_count,length(symbol)) + 1i*(sqrt(N/2)*randn(RX_count,length(symbol)));      %���� ����
h = sqrt(0.5) * [randn(RX_count,length(symbol)) + 1i*randn(RX_count,length(symbol))];       % Rayleigh channel

[value index] = max(abs(h));
h_SC = zeros(1,length(h));
for i = 1:1:length(symbol)
    h_SC(1,i) = h(index(1,i),i);              % select h
end

[value index] = max(abs(noise));
noise_SC = zeros(1,length(noise));
for i = 1:1:length(symbol)
    noise_SC(1,i) = noise(index(1,i),i);        % select noise
end

h_c = conj(h_SC);      % h_rms_max�� �ӷ����Ҽ� ����
symbol_h = symbol.*h_SC;   % hx
symbol_noise = symbol_h + noise_SC;    % hx + n


symbol_noise = symbol_noise .* h_c;
symbol_noise = symbol_noise ./ (h_SC .* h_c);
result = symbol_noise;
end