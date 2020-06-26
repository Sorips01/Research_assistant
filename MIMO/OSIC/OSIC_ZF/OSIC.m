function [result,h] = OSIC(Demo_symbol,i,h,r)
r=r-h(:,1)*Demo_symbol(i,1);
result = r;
h(:,1) = [];
end