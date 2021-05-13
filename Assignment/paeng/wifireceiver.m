function [message, len, start] = wifireceiver(txsignal,level)
    
    %% Some Constants
    Trellis = poly2trellis(7,[133 171]);
    nfft = 64;
    preamble = [1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1, 1, 1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1, 1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1,-1,-1,-1,-1,-1, 1, 1,-1, -1, 1,-1, 1,-1, 1, 1, 1, 1,-1,-1, -1,-1,-1, 1, 1,-1, -1, 1];
    tbdepth = 64;
    Interleave = reshape(reshape([1:nfft], 4, []).', [], 1);
    decodeSignal = txsignal;

    %% decode Level 5
    if (level >= 5)
        distanceList = zeros(1, (length(decodeSignal) - nfft + 1));
        preambleInvFFT = ifft(preamble);
        % compare preamble
        for i = 1:(length(decodeSignal) - nfft + 1)
            subDecodeSignal = decodeSignal(i:i+nfft-1);
            distance = sqrt((real(subDecodeSignal) - real(preambleInvFFT)).^2 + ((imag(subDecodeSignal) - imag(preambleInvFFT)).^2));
            distanceList(i) = mean(distance);
        end
        
        % find location of preamble
        [~, preambleStartIndex] = min(distanceList);
        txsignal = txsignal(preambleStartIndex:end);
    end
    
    %% decode Level 4
    if (level >= 4)    
        nsym = length(decodeSignal)/nfft;
        
        for ii = 1:nsym
            % devide symbols and then, run fft    
            decodeSymbol = decodeSignal(((ii-1)*nfft)+1:ii*nfft);
            decodeSignal(((ii-1)*nfft)+1:ii*nfft) = fft(decodeSymbol);
        end
    end
    
    %% decode Level 3
    if (level >= 3)
        preamble = decodeSignal(1:64);
        decodeSignal = decodeSignal(65:end);    % remove preamble
        decodeSignal = decodeSignal > 0;        % demodulation BPSK
    end

    %% decode Level 2
    if (level >= 2)
        nsym = length(decodeSignal)/nfft;
        
        for ii = 1:nsym
            decodeSymbol = decodeSignal(((ii-1)*nfft)+1:ii*nfft);
            % decodeSignal(((ii-1)*nfft)+1:ii*nfft) = reshape(reshape(decodeSymbol, [], 4).', 1, []);
            decodeSymbol(Interleave) = decodeSymbol(1:64);
            decodeSignal(((ii-1)*nfft)+1:ii*nfft) = decodeSymbol;
        end
    end

    %% decode Level 1
    if (level >= 1)
        % eliminate pre-pend
        lenMessage = bi2de(decodeSignal(1:nfft), 'left-msb');
        
        length_end = (floor((lenMessage*8)/nfft)+1)*64*2+64;

        decodeSignal = decodeSignal(nfft + 1:length_end);
        
        % we apply the turbod decoder
        decodeSignal = vitdec(decodeSignal, Trellis, tbdepth, 'trunc','hard');
        
        % we eliminate multifple of nfft
        decodeSignal = decodeSignal(1:end - mod(-(lenMessage * 8), nfft));
        
        % so we reshape mssage matrix
        decodeSignal = reshape(decodeSignal',[8, lenMessage]).';
        
        % and binary to decimal & decimal to char
        decodeOutput = char(bin2dec(num2str(decodeSignal))).';
    end

    %% output
    message = decodeOutput;
    len = lenMessage;

    if (level >= 5)
        strat = preambleStart - 1;
    else
        start = 0;
    end
end

