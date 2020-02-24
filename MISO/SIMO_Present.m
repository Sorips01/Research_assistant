clear all;
Tx = 2;
Rx = 1;
result = [];
for SNR=0:5:20
    N=10^(-0.1*SNR);
    error = zeros(3,1);
    trial = 0;
    while min(error) < 200
        trial= trial + 1;
        b = randi([0,1],4,1);
        s(1) = (2*b(1)-1 + j*(2*b(2)-1))/sqrt(2);                
        s(2) = (2*b(3)-1 + j*(2*b(4)-1))/sqrt(2);                
        
        h = (randn(1,Tx)+j*randn(1,Tx))/sqrt(2);      
        r1 = h*[s(1),s(2)] + (randn(Rx,1)+j*randn(Rx,1))*sqrt(N/2);
        r2 = h*[-s(2)',s(1)'] + (randn(Rx,1)+j*randn(Rx,1))*sqrt(N/2);
        
        first_symbol_detection = (h(1)'*r1+h2*r2')/(sum(abs(h).^2));
        second_symbol_detection = (h(1)'*r1+h2*r2')/(sum(abs(h).^2));
        
        
        
        precoding_vector = conj(h) / sqrt(sum(abs(h).^2));
        
        tx_vector = (precoding_vector*s).';
        r = h*tx_vector + n;
        
        
        [~, order] = max(abs(h));
        tx_vector = zeros(Tx,1);
        tx_vector(order) = s;                
        n = (randn(Rx,1)+j*randn(Rx,1))*sqrt(N/2);
        r = h(order)*s+n;
        r = h*tx_vector + n;
        
        
        
        
        
        
        MRC = h'*r;
        EGC = (h'./(abs(h')))*r;
        [~, location] = max(abs(h));
        SC = conj(h(location))*r(location);
        
        MRC_result(1,1) = real(MRC)>0;
        MRC_result(2,1) = imag(MRC)>0;
        EGC_result(1,1) = real(EGC)>0;
        EGC_result(2,1) = imag(EGC)>0;
        SC_result(1,1) = real(SC)>0;
        SC_result(2,1) = imag(SC)>0;
        
        error(1) = error(1) + sum(abs(b-MRC_result));
        error(2) = error(2) + sum(abs(b-EGC_result));
        error(3) = error(3) + sum(abs(b-SC_result));
    end
    error = error / (trial*2);
    [SNR error.']
    result = [result;error.'];
end

        
        