%% 201715081 kijiyeon [main]

%  x is input signal, map is color info
[x,map] = imread('Lena.png');

y=uint8(zeros(size(x)));
for b = 1:2:100
    % [y,order] = FIR_LPF_Filtering(x,y);
    % [z,b] = FIR_HPF_Filtering(x,y);
    [row,col] = size(x);
    k = [];
    % b = 50;
    
    for i = 1:row
        k(i,:) = [zeros(1,1), x(i,:), zeros(1,1)];
    end
    
    k = [zeros(1,258); k ; zeros(1,258)];
    
    for m = 2:row
        for n = 2:col
            y(m,n) = 3*k(m,n)-(k(m+1,n) + k(m-1,n) + k(m,n+1) + k(m,n-1)) +0.25 * (k(m+1,n+1) + k(m+1,n-1) + k(m-1,n+1) + k(m-1, n-1));
            
            z(m-1,n-1) = x(m,n) + b * y(m,n);
        end
    end
    %% save files
    % fileNameLPF = strcat('lena',string(order),'_LPF.jpg');
    % imwrite(y,map,fileNameLPF);
    
    fileNameHPF = strcat('lena',string(b),'_HPF.jpg');
    imwrite(z,map,fileNameHPF);
end