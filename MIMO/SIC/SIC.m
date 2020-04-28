function [result,h] = SIC(r_result,h,r)

[~,maxIndex] = max(sum(abs(h)));
r=r-h(:,maxIndex)*r_result(maxIndex,1);
result = r;

h(:,maxIndex) = [];

end