%% 201715081 kijiyeon [main]

%  x is input signal, map is color info
[x,map] = imread('lena.png')

y=uint8(zeros(size(x)));

y = FIR_LPF_Filtering(x);
% y = reshape(y,[121,3]);
imwrite(y,map,'lena.jpg')