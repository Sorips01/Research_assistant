function [estimatedResult] = EstimatingX(r_result)

    estimatedBit(:,1) = real(r_result)>0;
    estimatedBit(:,2) = imag(r_result)>0; 

    estimatedResult = 2 * estimatedBit - 1;
    estimatedResult = estimatedResult(:,1) + estimatedResult(:,2) * 1j;
    
end
