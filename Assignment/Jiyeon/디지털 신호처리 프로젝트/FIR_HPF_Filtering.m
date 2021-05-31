
function [result, order] = FIR_HPF_Filtering(x,y)

[row,col] = size(x);
k = [];
b = 3;

for i = 1:row
    k(i,:) = [zeros(1,1), x(i,:), zeros(1,1)];
end

k = [zeros(1,258); k ; zeros(1,258)];

for m = 2:row
    for n = 2:col
        y(m,n) = 3*k(m,n)-(k(m+1,n) + k(m-1,n) + k(m,n+1) + k(m,n-1)) +0.25 * (k(m+1,n+1) + k(m+1,n-1) + k(m-1,n+1) + k(m-1, n-1));
        
        z(m,n) = x(m,n) + b * y(m,n);
    end
end
result = z;
order = b;

end