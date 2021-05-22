%% 201715081 kijiyeon [main]

%  x is input signal, map is color info
[x,map] = imread('lena.png')

y=uint8(zeros(size(x)));

[y,order] = FIR_LPF_Filtering(x,y);
[z,b] = FIR_HPF_Filtering(x,y);

%% save files 
fileNameLPF = strcat('lena',string(order),'_LPF.jpg'); 
imwrite(y,map,fileNameLPF);

fileNameHPF = strcat('lena',string(b),'_HPF.jpg'); 
imwrite(z,map,fileNameHPF);