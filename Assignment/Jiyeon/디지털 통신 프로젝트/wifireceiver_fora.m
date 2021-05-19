function [message,len, start] = wifireceiver_fora(txsignal,level)

%% Some Constants
Trellis = poly2trellis(7,[133 171]);
nfft = 64;
tbdepth = 34;
decodeSignal = txsignal;

%% Level #5

% decodeSignal = 
decodeSymbol = pskdemod(decodeSignal,2,0,'bin');
% for j = 0:2:(length(decodeSymbol)-2)
%     for k = 0:1:(0.5*length(decodeSymbol)-1)
%         if(decodeSymbol(j) == 1 && decodeSymbol(j+1) == 1)
%             decodeSignal(k) = 1+1i;
%         end
%         if(decodeSymbol(j) == 1 && decodeSymbol(j+1) == 0)
%             decodeSignal(k) = 1-1i;
%         end
%         if(decodeSymbol(j) == 0 && decodeSymbol(j+1) == 1)
%             decodeSignal(k) = -1+1i;
%         end
%         if(decodeSymbol(j) == 0 && decodeSymbol(j+1) == 0)
%             decodeSignal(k) = -1-1i;
%         end
%         
%     end
    
    
    %% Level #4
    
    nsym = length(decodeSignal)/nfft;
    
    for ii = 1:nsym
        decodeSymbol = decodeSignal((ii-1)*nfft+1:ii*nfft);
        decodeSignal((ii-1)*nfft+1:ii*nfft) = fft(decodeSymbol);
    end
    
    %% Level #3
    
%     preamble = decodeSignal(1:64);
    decodeSignal = decodeSignal(65:end);
    decodeSignal = decodeSignal>0;
    
    %% Level #2
    
    nsym = length(decodeSignal)/nfft;
    
    for ii=1:nsym
        decodeSymbol = decodeSignal((ii-1)*nfft+1:(ii*nfft));
        decodeSignal((ii-1)*nfft+1:ii*nfft) = reshape(reshape(decodeSymbol, [], 4).', 1, []);
    end
    
    %% Level #1
    
    if(level>=1)
        lenMessage = bi2de(decodeSignal(1:nfft), 'left-msb');
        
        decodeSignal = decodeSignal(nfft + 1:end);
        decodeSignal = vitdec(decodeSignal, Trellis, tbdepth, 'trunc','hard');
        decodeSignal = decodeSignal(1:end - mod(-(lenMessage * 8), nfft));
        decodeSignal = reshape(decodeSignal',[8, lenMessage]).';
        decodeOutput = char(bin2dec(num2str(decodeSignal))).';
        
        % message = decodeOutput;
        % len = lenMessage;
        % start = 0;
    end
    message = decodeOutput;
    len = lenMessage;
    start = 0;
end

