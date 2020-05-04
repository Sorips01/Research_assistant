function [result,h] = OSIC_ZF(r_result,h,r)
[~,index] = max(sum(abs(h)));
r=r-h(:,index)*r_result(index,1);
result = r;
h(:,index) = [];
end