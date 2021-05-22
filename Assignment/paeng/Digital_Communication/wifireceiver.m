function [message, len, start] = wifireceiver(txsignal,level)
    %% Setting
    if (nargin < 2)
        level = 5;
    end
    
    if(level > 5 || level < 1)
        fprintf(2, 'Error: Invalid level \n');
        message=[];
        len = 0;
        start = 0;
        return;
    end

    %% Some Constants
    
    % This is the Encoder/decoder trellis used by WiFi's turbo encoder
    Trellis = poly2trellis(7,[133 171]);

    % We will split the data into a cluster of nfft bits
    nfft = 64;

    % Every WiFi packet will start with this exact preamble
    preamble = [1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1, 1, 1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1, 1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1,-1,-1,-1,-1,-1, 1, 1,-1, -1, 1,-1, 1,-1, 1, 1, 1, 1,-1,-1, -1,-1,-1, 1, 1,-1, -1, 1];

    % Every 64 bits are mixed up like below:
    Interleave = reshape(reshape([1:nfft], 4, []).', [], 1);

    %% decode start
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
        decodeSignal = decodeSignal(preambleStartIndex:end);
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
        preambleLength = length(preamble);
        preamble = decodeSignal(1:preambleLength);
        decodeSignal = decodeSignal(preambleLength + 1:end);    % remove preamble
        decodeSignal = decodeSignal > 0;        % demodulation BPSK
    end

    %% decode Level 2
    if (level >= 2)
        nsym = length(decodeSignal)/nfft;
        
        for ii = 1:nsym
            decodeSymbol = decodeSignal(((ii-1)*nfft)+1:ii*nfft);
            % decodeSignal(((ii-1)*nfft)+1:ii*nfft) = reshape(reshape(decodeSymbol, [], 4).', 1, []);
            decodeSymbol(Interleave) = decodeSymbol;
            decodeSignal(((ii-1)*nfft)+1:ii*nfft) = decodeSymbol;
        end
    end

    %% decode Level 1
    if (level >= 1)
        % eliminate pre-pend
        lenMessage = bi2de(decodeSignal(1:nfft), 'left-msb');
        
        lengthEnd = nfft * (2 * (floor((lenMessage*8)/nfft)+1) + 1);

        decodeSignal = decodeSignal(nfft + 1:lengthEnd);
        
        % we apply the turbod decoder
        tbdepth = 64;
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
        start = preambleStartIndex - 1;
    else
        start = 0;
    end

    if (level < 5)
        fprintf('%s', message);
    elseif (level == 5)
        fprintf("message = '%s' \n", message);
        fprintf('length = %d \n', len);
        fprintf('start = %d \n', start);
    end
end

