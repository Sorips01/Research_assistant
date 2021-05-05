function [message, length, start] = wifireceiver(txsignal, level)

    %% Some constatns
    nfft = 64;
    tbdepth = 64;
    Trellis = poly2trellis(7,[133 171]);
    len = bi2de(txsignal(1:nfft), 'left-msb');
    
%% decode Level 1
if(level >=1)    
    % Remove pre-pend the length to the message
    txsignal = txsignal(nfft+1:end);
    
    % Reversal process of turbo coder
    txsignal = vitdec(txsignal, Trellis, tbdepth, 'term','hard');
    
    % Remove a multiple of nfft
    txsignal = txsignal(1:end - mod(-(len * 8),nfft))
    
    % Next, we reshape message
    txsignal = reshape(txsignal',[8, len]).';
    
    % Finally, we convert the message to char
    txsignal = char(bin2dec(num2str(txsignal))).';
    
    start = 0;
    length = len;
    message = txsignal;
end
end