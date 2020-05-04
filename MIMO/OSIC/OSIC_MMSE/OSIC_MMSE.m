function [result,h] = OSIC_MMSE(r_result,h,r)
r=r-h(:,1)*r_result(1,1);
result = r;
h(:,1) = [];

end