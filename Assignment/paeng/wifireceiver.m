function [message,length, start] = wifireceiver(txsignal,level)
    
    %% Some Constants
    Trellis = poly2trellis(7,[133 171]);

    nfft = 64;
    lenMessage = bi2de(txsignal(1:nfft), 'left-msb');
    
    tbdepth = 34;

    %% decode Level 1
    % eliminate pre-pend
    txsignal = txsignal(nfft + 1:end);
    
    % we apply the turbod decoder
    decodeSignal = vitdec(txsignal, Trellis, tbdepth, 'trunc','hard');
    
    % we eliminate multifple of nfft
    decodeSignal = decodeSignal(1:end - mod(-(lenMessage * 8), nfft));
    
    % so we reshape mssage matrix
    decodeSignal = reshape(decodeSignal',[8, lenMessage]).';
    
    % and binary to decimal & decimal to char
    decodeOutput = char(bin2dec(num2str(decodeSignal))).';
    
    message = decodeOutput;
    length = lenMessage;
    start = 0;
end

