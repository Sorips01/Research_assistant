function [result,h] = SIC(r_result,h,r)

r=r-h(:,maxIndex)*r_result(maxIndex,1);
result = r;
h(:,maxIndex) = [];
end