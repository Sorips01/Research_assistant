function result = Noise_maker_Selection(N, TX_count, symbol)
noise =sqrt(N/2)*randn(1,length(symbol)) + 1i*(sqrt(N/2)*randn(1,length(symbol)));      %���� ����
%h = sqrt(0.5) * [randn(RX_count,length(symbol)) + 1i*randn(RX_count,length(symbol))];       % Rayleigh channel
h = sqrt(0.5) * [randn(1,length(symbol)) + 1i*randn(1,length(symbol))];       % Rayleigh channel
%    
% temp = h;
% for mrc = 1:1:RX_count-1
%     h = [h;temp];
% end

% temp_2 = symbol;
% for mrc = 1:1:RX_count-1
%     symbol = [symbol;temp_2];
% end


h_c = conj(h);      % h �ӷ����Ҽ� ����
symbol_h = symbol.*h;
symbol_noise=symbol_h+noise;

%symbol_noise = zeros(1,length(symbol));

symbol_noise = symbol_noise .* h_c;
symbol_noise = sum(symbol_noise);
h_square = zeros(1,length(h));

h_square = h.*h_c;
symbol_noise = symbol_noise ./ sum(h_square);

result = symbol_noise;
end