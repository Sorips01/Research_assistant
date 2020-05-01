<<<<<<< Updated upstream
function [result,h] = SIC(r_result,h,r)

[~,maxIndex] = max(sum(abs(h)));
r=r-h(:,maxIndex)*r_result(maxIndex,1);
result = r;

h(:,maxIndex) = [];

=======
function [result,h] = SIC(r_result,h,r,i)
r=r-h(:,1)*r_result(1,1);
result = r;
h(:,1) = [];
>>>>>>> Stashed changes
end