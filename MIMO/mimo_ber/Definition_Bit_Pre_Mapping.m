function [bitset, symset] = Definition_Bit_Pre_Mapping(M, Q, QAM)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for i=1:Q-1
    bitset_temp(i,:) = dec2bin(i,M); % dec2bin : 십진수를 이진수로 표현한 문자형 배열로 변환
end
bitset_temp(Q,:) = dec2bin(0,M);
for i=1:M
    for n=1:Q
    bitset(n,i) = bin2dec(bitset_temp(n,i));
    end
end

if QAM == 1 % QAM Modulation    
    if M==1 % 2-QAM = BPSK
        symset = 2*bitset-1;    
    elseif M==2 % 4-QAM = QPSK
        symset = 2*bitset(:,1)-1+j*(2*bitset(:,2)-1);
        symset = symset / sqrt(2);       
    elseif M==4 % 16QAM
        symset = (1-2*bitset(:,1)).*(2*bitset(:,3)+1)+ j*(1-2*bitset(:,2)).*(2*bitset(:,4)+1);
        symset = symset / sqrt(10);
    elseif M==6 % 64QAM    
        symset = (1-2*bitset(:,1)).*(4+(2*bitset(:,3)-1).*(2*bitset(:,5)+1));
        symset = symset + j*((1-2*bitset(:,2)).*(4+(2*bitset(:,4)-1).*(2*bitset(:,6)+1)));
        symset = symset / sqrt(42);        
    end
elseif QAM == 0 % PSK Modulation - Up to 16-PSK
    if M==1 % BPSK = 2-QAM
        symset = 2*bitset-1;    
    elseif M==2 % QPSK = 4-QAM
        symset = 2*bitset(:,1)-1+j*(2*bitset(:,2)-1);
        symset = symset / sqrt(2);       
    elseif M==3 % 8-PSK        
        for n=1:Q
            if bitset(n,1) == 1 & bitset(n,2) == 1 & bitset(n,3) == 1
                theta(n,1) = 0;
            elseif bitset(n,1) == 1 & bitset(n,2) == 1 & bitset(n,3) == 0
                theta(n,1) = 0.25;
            elseif bitset(n,1) == 0 & bitset(n,2) == 1 & bitset(n,3) == 0
                theta(n,1) = 0.5;
            elseif bitset(n,1) == 0 & bitset(n,2) == 1 & bitset(n,3) == 1
                theta(n,1) = 0.75;
            elseif bitset(n,1) == 0 & bitset(n,2) == 0 & bitset(n,3) == 1
                theta(n,1) = 1;
            elseif bitset(n,1) == 0 & bitset(n,2) == 0 & bitset(n,3) == 0
                theta(n,1) = 1.25;
            elseif bitset(n,1) == 1 & bitset(n,2) == 0 & bitset(n,3) == 0
                theta(n,1) = 1.5;
            elseif bitset(n,1) == 1 & bitset(n,2) == 0 & bitset(n,3) == 1
                theta(n,1) = 1.75;
            end
        end
        symset = exp(j*pi*theta);
    elseif M==4 %16PSK
        for n=1:Q
            if bitset(n,1) == 0 & bitset(n,2) == 0 & bitset(n,3) == 0 & bitset(n,4) == 0
                theta(n,1) = 0;
            elseif bitset(n,1) == 0 & bitset(n,2) == 0 & bitset(n,3) == 0 & bitset(n,4) == 1
                theta(n,1) = 1/8;
            elseif bitset(n,1) == 0 & bitset(n,2) == 0 & bitset(n,3) == 1 & bitset(n,4) == 1
                theta(n,1) = 2/8;
            elseif bitset(n,1) == 0 & bitset(n,2) == 0 & bitset(n,3) == 1 & bitset(n,4) == 0
                theta(n,1) = 3/8;
            elseif bitset(n,1) == 0 & bitset(n,2) == 1 & bitset(n,3) == 1 & bitset(n,4) == 0
                theta(n,1) = 4/8;
            elseif bitset(n,1) == 0 & bitset(n,2) == 1 & bitset(n,3) == 1 & bitset(n,4) == 1
                theta(n,1) = 5/8;
            elseif bitset(n,1) == 0 & bitset(n,2) == 1 & bitset(n,3) == 0 & bitset(n,4) == 1
                theta(n,1) = 6/8;
            elseif bitset(n,1) == 0 & bitset(n,2) == 1 & bitset(n,3) == 0 & bitset(n,4) == 0
                theta(n,1) = 7/8;
            elseif bitset(n,1) == 1 & bitset(n,2) == 1 & bitset(n,3) == 0 & bitset(n,4) == 0
                theta(n,1) = 8/8;
            elseif bitset(n,1) == 1 & bitset(n,2) == 1 & bitset(n,3) == 0 & bitset(n,4) == 1
                theta(n,1) = 9/8;
            elseif bitset(n,1) == 1 & bitset(n,2) == 1 & bitset(n,3) == 1 & bitset(n,4) == 1
                theta(n,1) = 10/8;
            elseif bitset(n,1) == 1 & bitset(n,2) == 1 & bitset(n,3) == 1 & bitset(n,4) == 0
                theta(n,1) = 11/8;
            elseif bitset(n,1) == 1 & bitset(n,2) == 0 & bitset(n,3) == 1 & bitset(n,4) == 0
                theta(n,1) = 12/8;
            elseif bitset(n,1) == 1 & bitset(n,2) == 0 & bitset(n,3) == 1 & bitset(n,4) == 1
                theta(n,1) = 13/8;
            elseif bitset(n,1) == 1 & bitset(n,2) == 0 & bitset(n,3) == 0 & bitset(n,4) == 1
                theta(n,1) = 14/8;        
            elseif bitset(n,1) == 1 & bitset(n,2) == 0 & bitset(n,3) == 0 & bitset(n,4) == 0
                theta(n,1) = 15/8;        
            end
        end
        symset = exp(j*pi*theta);
    else % Q(2^M)-PSK. It is not the optimal constellation for Q.
        ratio = 2 / Q;
        for n=1:Q-1
            theta(n,1) = ratio * n;
        end
        theta(Q,1) = 0;        
        symset = exp(j*pi*theta);        
    end
end    
        