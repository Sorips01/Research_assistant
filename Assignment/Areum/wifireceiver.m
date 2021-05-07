function [message, Length, start] = wifireceiver(txsignal, level)

    %% Some constatns
    nfft = 64;
    tbdepth = 64;
    Trellis = poly2trellis(7,[133 171]);
    Interleave = reshape(reshape([1:nfft], 4, []).', [], 1);
    
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
end
%% decode Level 1
if(level >=1)
    len = bi2de(rxsignal(1:nfft), 'left-msb');
    
    % Remove pre-pend the length to the message
    rxsignal = rxsignal(nfft+1:end);
    
    % Reversal process of turbo coder
    rxsignal = vitdec(rxsignal, Trellis, tbdepth, 'term','hard');
    
    % Remove a multiple of nfft
    rxsignal = rxsignal(1:end - mod(-(len * 8),nfft));
    
    % Next, we reshape message
    rxsignal = reshape(rxsignal',[8, len]).';
    
    % Finally, we convert the message to char
    rxsignal = char(bin2dec(num2str(rxsignal))).';
    
    start = 0;
    Length = len;
    message = rxsignal;
end
end