function [message,len, start] = wifireceiver(txsignal,level)
rSignal = txsignal;
nfft = 64;
Trellis = poly2trellis(7,[133 171]);
tbdepth = 34;
invInterleave = reshape(reshape([1:nfft], [], 4).', 1, []);
preamble = [1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1, 1, 1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1, 1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1,-1,-1,-1,-1,-1, 1, 1,-1, -1, 1,-1, 1,-1, 1, 1, 1, 1,-1,-1, -1,-1,-1, 1, 1,-1, -1, 1];

%% level #5
if(level>=5)
    %preamble이랑 거리구하기
    %     distance = 0;
    ifftPreamble = ifft(preamble);
    
    iithDistance = zeros(1,nfft);
    
    for jj = 1:(length(rSignal)-64)
        
        storeDistance =[];
        
        comprSignal = zeros(1,nfft);
        comprSignal = rSignal(jj:jj+nfft-1);
        
        distance = sqrt((real(comprSignal) - real(ifftPreamble)).^2 + (imag(comprSignal)-imag(ifftPreamble)).^2);
        storeDistance = [storeDistance, distance];
        
        iithDistance(jj) = sum(storeDistance)/length(storeDistance);
        
    end
    [~,index] = min(iithDistance);
    
    rSignal = rSignal(index:end);
end
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
    rSignal = pskdemod(rSignal,2);
    %     rSignal = rSignal>0;
    for ii = 1:(length(rSignal))
        if(rSignal(ii)>0)
            rSignal(ii) = 0;
        else
            rSignal(ii) = 1;
        end
    end
    
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
    length_end = (floor((lenMessage*8)/nfft)+1)*64*2+64;
    
    rSignal = rSignal(nfft + 1:length_end);
    rSignal = vitdec(rSignal, Trellis, tbdepth, 'trunc','hard');
    rSignal = rSignal(1:end - mod(-(lenMessage * 8), nfft));
    rSignal = reshape(rSignal',[8, lenMessage]).';
    
    rOutput = char(bin2dec(num2str(rSignal))).';
    
    
    
end

if(level>=5)
    fprintf("message = %s \n",rOutput);
    fprintf("length= %d \n", length(rOutput));
    fprintf("start = %d \n",index);
end

message = rOutput;
len = lenMessage;
start = 0;
end