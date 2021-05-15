function [message, Length, start] = wifireceiver(txsignal, level)
%% Some constatns
    nfft = 64;
    tbdepth = 64;
    Trellis = poly2trellis(7,[133 171]);
    Interleave = reshape(reshape([1:nfft], 4, []).', [], 1);
    preamble = [1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1, 1, 1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1, 1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1,-1,-1,-1,-1,-1, 1, 1,-1, -1, 1,-1, 1,-1, 1, 1, 1, 1,-1,-1, -1,-1,-1, 1, 1,-1, -1, 1];
%% decode Level 5
if(level >= 5)
    distance = [];
    preamble = ifft(preamble);
    
    for ii = 1:(length(txsignal)-64)
        % Collect the iith symbol
        symbol = txsignal(ii:ii-1+nfft);
        
        % Measure distance
        a = sqrt((real(symbol)-real(preamble)).^2+(imag(symbol)-imag(preamble)).^2);
        a = sum(a)/64;
        distance = [distance a];
    end
    
    % find location of preamble
    [~,preamble_start]=find(distance==min(distance));
    txsignal = txsignal(preamble_start:end);
end
%% decode Level 4
if(level >= 4)
    % Number of symbols in message
    nsym = length(txsignal)/nfft;
    
    for ii = 1:nsym
        % Collect the iith symbol
        symbol = txsignal((ii-1)*nfft+1:ii*nfft);
        
        % Run an FFT on the symbol
        txsignal((ii-1)*nfft+1:ii*nfft) = fft(symbol);
    end
end
%% decode Level 3
if(level >= 3)
    % Remove a preamble
    txsignal = txsignal(65:end);
    
    % Demodulation
    txsignal = txsignal > 0;
end
%% decode Level 2
if(level >= 2)
    % Number of symbols in message
    nsym = length(txsignal)/nfft;
    
    for ii = 1:nsym
        % Collect the iith symbol
        symbol = txsignal((ii-1)*nfft+1:ii*nfft);
        
        %  Reversal process of Interleave the symbol
        symbol(Interleave) = symbol(1:64);
        rxsignal((ii-1)*nfft+1:ii*nfft) = symbol;
    end
    
    txsignal = rxsignal;
end
%% decode Level 1
if(level >=1)
    len = bi2de(txsignal(1:nfft), 'left-msb');
    
    % Find end of length 
    length_end = (floor((len*8)/nfft)+1)*64*2+64;
    
    % Remove pre-pend the length to the message
    txsignal = txsignal(nfft+1:length_end);
    
    % Reversal process of turbo coder
    txsignal = vitdec(txsignal, Trellis, tbdepth, 'term','hard');
    
    % Remove a multiple of nfft
    txsignal = txsignal(1:end - mod(-(len * 8),nfft));
    
    % Next, we reshape message
    txsignal = reshape(txsignal',[8, len]).';
    
    % Finally, we convert the message to char
    txsignal = char(bin2dec(num2str(txsignal))).';
    
    if(level == 5) 
        start = preamble_start - 1;
    else
        start = 0;
    end
    
    Length = len;
    message = txsignal;
end
end