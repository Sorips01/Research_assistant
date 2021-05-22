%% 201715081 kijiyeon [FIR HPF Filtering]

function [result, filterOrder] = FIR_HPF_Filtering(x,y)

% padding = zeros(size(x)+4);
% [pRow pCol] = size(padding);
% 
% for i = 2:pRow-1
% for j = 2:pCol-1
%     padding(i,j) = x(i-1,j-1);
% end
% end
% 
% x = padding;

[row col] = size(x);

b = 11;

for m = 2:col
for n = 2:row
    y(m,n) = 3*(x(m,n))-(x(m+1,n) + x(m-1,n)+x(m,n+1)+x(m,n-1))+0.25*(x(m+1,n+1)+x(m+1,n-1)+x(m-1,n+1)+x(m-1,n-1));
    z(m,n) = x(m,n)+b*y(m,n);
end
end
result = z;
filterOrder = b;
end
