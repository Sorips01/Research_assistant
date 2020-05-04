function [estimatedResult] = EstimatingX(r_result)

    estimatedBit(1,1) = real(r_result)>0;
    estimatedBit(1,2) = imag(r_result)>0; 

    estimatedResult = 2 * estimatedBit - 1;
    estimatedResult = estimatedResult(1,1) + estimatedResult(1,2) * 1j;
    
end
