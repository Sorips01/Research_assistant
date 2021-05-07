%% wifitransmitter: Creates a Wi-Fi packet
% output = WiFi packet
% Inputs: message = text message, snr = signal to noise ratio,
% level = number of stages of encoding
function output = wifitransmitter(message, level, snr)
%% Default values
if(nargin < 2)
    level = 5;
end
if(nargin < 3)
    snr = Inf;
end

%% Sanity checks

% check if message length is reasonable
if(length(message) > 10000)
    fprintf(2, 'Error: Message too long\n');
    output=[];
    return;
end

% check if level is between 1 and 5
if(level > 5 || level < 1)
    fprintf(2, 'Error: Invalid level, must be 1-5\n');
    output=[];
    return;
end

%% Some constants

% We will split the data into a cluster of nfft bits
nfft = 64;
% m. nfft indicates the number of samples in FFT, when you do OFDM

% This is the Encoder/decoder trellis used by WiFi's turbo encoder
Trellis = poly2trellis(7,[133 171]);

% Every WiFi packet will start with this exact preamble
preamble = [1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1, 1, 1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1, 1, 1, 1, 1,-1,-1, 1, 1,-1, 1,-1, 1,-1,-1,-1,-1,-1, 1, 1,-1, -1, 1,-1, 1,-1, 1, 1, 1, 1,-1,-1, -1,-1,-1, 1, 1,-1, -1, 1];

% Every 64 bits are mixed up like below:
Interleave = reshape(reshape([1:nfft], 4, []).', [], 1);

%% Lets learn about the message
% Length
len = length(message);

%% Level #1: First lets do coding, which adds redundancy to the bits
if (level >= 1)
    % This basically converts the message into a sequence of bits
    bits = reshape(dec2bin(double(message).', 8).', 1, [])-'0';
    
    % dec2bin : message를 10진수에서 2진수 형식으로 바꿈, 8자리수로 지정(필요한 자리수보다 더 많이 지정하면 출력값을 0으로 채움
    % reshape(A,sz1,...,szN) : A를 sz1x...xsxN 배열로 형태 변경
    % reshape : 2진수 형식으로 바꾼 상태에서 전치 -> 1x(차원의 크기) 행렬 형태로 변경 ([ ]로 지정한 경우)
    % 11x8 = 88
    
    % We append as many bits as necessary to make this a multiple of
    % nfft
    bits = [bits, zeros(1, mod(-length(bits), nfft))];
    
    % bits의 길이를 nfft로 나눈 나머지만큼 bits 뒤에 0을 붙임 -> 128
    
    % Next, we apply the turbo coder
    output = convenc(bits, Trellis);
    
    % convenc : 2진수를 컨볼루션 방식으로 encoding -> 256
    
    % Finally, let's pre-pend the length to the message
    output = [dec2bin(len, nfft)-'0', output];
    
    % message길이(11)을 nfft(64) 길이로 지정하여 2진수로 바꿔서 앞에 붙임 -> 64 + 256 = 320
end


%% Level #2: Next, lets do interleaving, which permutes the bits
if (level >= 2)
    % Number of symbols in message
    nsym = length(output)/nfft;
    
    % 64개씩 Interleave에 맞춰서 output을 섞음
    for ii = 1:nsym
        % Collect the iith symbol
        symbol = output((ii-1)*nfft+1:ii*nfft);
        
        % Interleave the symbol
        % Interleave는 k번째 자리를 말함 (symbol의 3번째 원소가 output으로 감)
        output((ii-1)*nfft+1:ii*nfft) = symbol(Interleave);
    end
end

%% Level #3: Next, lets do modulation, which maps the bits to a modulation (BPSK)
if (level >= 3)
    % Do BPSK modulation
    output = 2*output-1;
    
    % Prepend a preamble
    output = [preamble, output];
end

%% Level #4: Next, lets create an OFDM packet
if (level >= 4)
    % Number of symbols in message
    nsym = length(output)/nfft;
    
    for ii = 1:nsym
        % Collect the iith symbol
        symbol = output((ii-1)*nfft+1:ii*nfft);
        
        % Run an FFT on the symbol
        output((ii-1)*nfft+1:ii*nfft) = ifft(symbol);
    end
end

%% Level #5: Finally, lets add some random padding and noise
if (level >= 5)
    % Lets add some (random) empty space to the beginning and end
    noise_pad_begin = zeros(1, round(rand*1000));
    noise_pad_end = zeros(1, round(rand*1000));
    
    length(noise_pad_begin)
    
    output = [noise_pad_begin, output, noise_pad_end];
    % This adds random numbers to the output.
    
    % Let's add additive white gaussian noise
    output = awgn(output, snr);
end

end
