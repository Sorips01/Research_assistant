function [message,len, start] = wifireceiver(txsignal,level)
rSignal = txsignal;
nfft = 64;
Trellis = poly2trellis(7,[133 171]);
tbdepth = 34;
invInterleave = reshape(reshape([1:nfft], [], 4).', 1, []);

%% level #5



%% level #4
if(level>=4)
    nsym = length(rSignal)/nfft;
    
    for ii=1:nsym
        rSymbol = rSignal((ii-1)*nfft+1:ii*nfft);
        rSignal((ii-1)*nfft+1:ii*nfft) = fft(rSymbol);
    end
    
end
%% level #3
if(level>=3)
    rSignal(1:nfft) = [];
    rSignal = rSignal>0;
end
%% level #2
if(level>=2)
    nsym = length(rSignal)/nfft;
    
    for ii = 1:nsym
        rSymbol = rSignal((ii-1)*nfft+1:ii*nfft);
        rSignal((ii-1)*nfft+1:ii*nfft)= rSymbol(invInterleave);
    end
end
%% level #1
if(level>=1)
    lenMessage = bi2de(rSignal(1:nfft),'left-msb');
    
    rSignal = rSignal(nfft + 1:end);
    rSignal = vitdec(rSignal, Trellis, tbdepth, 'trunc','hard');
    rSignal = rSignal(1:end - mod(-(lenMessage * 8), nfft));
    rSignal = reshape(rSignal',[8, lenMessage]).';
    
    rOutput = char(bin2dec(num2str(rSignal))).';
    
    message = rOutput;
    len = lenMessage;
    start = 0;
end
end