function [result,h] = SIC(symbol,h,r,i)
r=r-h(:,1)*symbol(i,1);
result = r;
h(:,1) = [];
end