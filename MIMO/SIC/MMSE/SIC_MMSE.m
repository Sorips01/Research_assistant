function [result,h] = SIC_MMSE(r_result,h,r,i)
r=r-h(:,1)*r_result(1,1);
result = r;
h(:,1) = [];
end