function [result,h] = OSIC_ZF(r_result,h,r)
[~,index] = max(sum(abs(h)));
estimatedResult = EstimatingX_OSIC(r_result,index);

r=r-h(:,index)*estimatedResult(1,1);
result = r;
h(:,index) = [];
end