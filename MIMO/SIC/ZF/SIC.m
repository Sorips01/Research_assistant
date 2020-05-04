function [result,h] = SIC(r_result,h,r,i)

estimatedResult(:,1) = real(Demo_symbol)>0;
estimatedResult(:,2) = imag(Demo_symbol)>0; 

r=r-h(:,1)*estimatedResult;

result = r;
h(:,1) = [];
end