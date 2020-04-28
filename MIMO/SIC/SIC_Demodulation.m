function [sicResult] = SIC_Demodulation(result,h,symbol)

sicResult = result - h(:,1)*symbol(1);

end
