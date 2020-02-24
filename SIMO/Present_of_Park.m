clear all;
Rx = 4;
result = [];
for SNR=0:5:20
    N=10^(-0.1*SNR);
    error = zeros(3,1);
    trial = 0;
    while min(error) < 200
        trial= trial + 1;
        b = randi([0,1],2,1);
        s = (2*b(1)-1 + j*(2*b(2)-1))/sqrt(2);
        h = (randn(1,1)+j*randn(1,1))/sqrt(2);
        h = h * ones(Rx,1);
        n = (randn(Rx,1)+j*randn(Rx,1))*sqrt(N/2);
        r = h*s+n;
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

        
        