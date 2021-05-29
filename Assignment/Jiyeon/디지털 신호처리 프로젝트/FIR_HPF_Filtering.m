%% 201715081 kijiyeon [FIR HPF Filtering]

function [result, filterOrder] = FIR_HPF_Filtering(x,y)

[row col] = size(x);
b = 150;

for i = 1:row
    padding_x(i,:) = [0 x(i,:) 0];
end

x = padding_x;
x = [zeros(1,258); x ; zeros(1,258)];

for m = 2:col
    for n = 2:row
        
        y(m,n) = 3*(x(m,n))-(x(m+1,n) + x(m-1,n)+x(m,n+1)+x(m,n-1))+0.25*(x(m+1,n+1)+x(m+1,n-1)+x(m-1,n+1)+x(m-1,n-1));
        z(m,n) = x(m,n)+b*y(m,n);
    end
end

result = z;
filterOrder = b;
end
