function result = Noise_maker_EGC(N, RX_count, symbol)
noise =sqrt(N/2)*randn(RX_count,length(symbol)) + 1i*(sqrt(N/2)*randn(RX_count,length(symbol)));      %���� ����
h = sqrt(0.5) * [randn(RX_count,length(symbol)) + 1i*randn(RX_count,length(symbol))];       % Rayleigh channel

h_c = conj(h);      % h �ӷ����Ҽ� ����

symbol_h = symbol.*h;
symbol_noise=symbol_h+noise;


symbol_noise = symbol_noise .* h_c;
symbol_noise = symbol_noise ./ abs(h_c);
symbol_noise = sum(symbol_noise);
%symbol_noise = symbol_noise ./ sum(abs(h));

result = symbol_noise;
end