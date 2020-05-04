function [result,h] = SIC_MMSE(r_result,h,r,i)

estimatedResult = EstimatingX(r_result)

r=r-h(:,1)*estimatedResult(1,1);
result = r;
h(:,1) = [];

end