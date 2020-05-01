function [sicResult] = SIC_Demodulation(Demo_symbol,h)

sicResult = Demo_symbol - h(:,1)*Demo_symbol(1)

end
