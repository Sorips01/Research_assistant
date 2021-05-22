function [message] = test(txsignal, level)
%% Some constatns
    nfft = 64;
    tbdepth = 64;
    Trellis = poly2trellis(7,[133 171]);
    Interleave = reshape(reshape([1:nfft], 4, []).', [], 1);
    preamble = [1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1, 1, 1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1, 1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1,-1,-1,-1,-1,-1, 1, 1,-1, -1, 1,-1, 1,-1, 1, 1, 1, 1,-1,-1, -1,-1,-1, 1, 1,-1, -1, 1];
%% level 5
    % Number of symbols in message
%     nsym = floor(length(txsignal)/nfft);
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
    [~,j]=find(distance==min(distance))
end