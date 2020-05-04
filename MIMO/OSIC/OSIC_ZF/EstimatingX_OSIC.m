function [estimatedResult] = EstimatingX_OSIC(r_result,index)
    estimatedBit(1,1) = real(r_result(index,:))>0;
    estimatedBit(1,2) = imag(r_result(index,:))>0; 

    estimatedResult = 2 * estimatedBit - 1;
    estimatedResult = estimatedResult(1,1) + estimatedResult(1,2) * 1j;
    
end
