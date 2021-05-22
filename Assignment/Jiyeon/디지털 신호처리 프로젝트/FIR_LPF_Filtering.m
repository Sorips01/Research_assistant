%% 201715081 kijiyeon [FIR LPF Filtering]

function [result, filterOrder] = FIR_LPF_Filtering(x,y)

%% moving average filter
order = 9;
y_n = zeros(size(x));
[row,col] = size(x);

for i= 1:col 
    inputX = [zeros(1,order-1),x(i,:)];
    for j = 1:row 
        for k = 1:order
            y(i,j) = y(i,j)+inputX(j+k-1);
        end
        y_n(i,j)= (1/order)*y(i,j);
    end
 
end
result = y_n;
filterOrder = order;
end
