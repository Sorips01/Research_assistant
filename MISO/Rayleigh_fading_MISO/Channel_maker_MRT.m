function result = Channel_maker_MRT(N, TX_count, symbol)
N=TX_count*N;
noise =sqrt(N/2)*randn(TX_count,length(symbol)) + 1i*(sqrt(N/2)*randn(TX_count,length(symbol)));      
h = sqrt(0.5) * [randn(TX_count,length(symbol)) + 1i*randn(TX_count,length(symbol))];       % Rayleigh channel

r = symbol.*h + noise;
r = r.*conj(h);

h_square = zeros(1,length(h));
h_square = sum(abs(h.*conj(h)));
r = r./ h_square;
r = sum(r);
result =r;

end