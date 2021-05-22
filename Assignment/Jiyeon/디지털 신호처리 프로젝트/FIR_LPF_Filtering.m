%% 201715081 kijiyeon [FIR LPF Filtering]

function result = FIR_LPF_Filtering(x)

%% moving average filter
order = 7;
y_n = zeros(size(x));

for r= 1:length(x) % = 256
    
    for c = 1:length(x) % = 256
        sumY = 0;
        for i = 0:order-1
            sumY = sumY+x(r+i);
        end
        
        y_n(r,c) = (1/order)*sumY;
    end
    
    
end
%% delay operator


result = y_n;
end
