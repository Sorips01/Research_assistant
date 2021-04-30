function [message,len, start] = wifireceiver(txsignal,level)
    
    %% Some Constants
    Trellis = poly2trellis(7,[133 171]);

    nfft = 64;
    
    
    tbdepth = 34;
    decodeSignal = txsignal;
    %% decode Level 4
    nsym = length(decodeSignal)/nfft;
    
    for ii = 1:nsym
       decodeSymbol = decodeSignal(((ii-1)*nfft)+1:ii*nfft);
       decodeSignal(((ii-1)*nfft)+1:ii*nfft) = fft(decodeSymbol);
    end
    
    %% decode Level 3
    preamble = decodeSignal(1:64);
    decodeSignal = decodeSignal(65:end);
    decodeSignal = decodeSignal > 0;
    
    %% decode Level 2
    nsym = length(decodeSignal)/nfft;
    
    for ii = 1:nsym
        decodeSymbol = decodeSignal(((ii-1)*nfft)+1:ii*nfft);
        decodeSignal(((ii-1)*nfft)+1:ii*nfft) = reshape(reshape(decodeSymbol, [], 4).', 1, []);
    end
    
    %% decode Level 1
    % eliminate pre-pend
    lenMessage = bi2de(decodeSignal(1:nfft), 'left-msb');
    
    decodeSignal = decodeSignal(nfft + 1:end);
    
    % we apply the turbod decoder
    decodeSignal = vitdec(decodeSignal, Trellis, tbdepth, 'trunc','hard');
    
    % we eliminate multifple of nfft
    decodeSignal = decodeSignal(1:end - mod(-(lenMessage * 8), nfft));
    
    % so we reshape mssage matrix
    decodeSignal = reshape(decodeSignal',[8, lenMessage]).';
    
    % and binary to decimal & decimal to char
    decodeOutput = char(bin2dec(num2str(decodeSignal))).';
    
    message = decodeOutput;
    len = lenMessage;
    start = 0;
end

