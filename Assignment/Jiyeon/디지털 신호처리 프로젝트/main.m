%% 201715081 kijiyeon [main]

%  x is input signal, map is color info
[x,map] = imread('Lena.png');

y=uint8(zeros(size(x)));
v = uint8(zeros(size(x)));

[y,order] = FIR_LPF_Filtering(x,y);
[z,b] = FIR_HPF_Filtering(x,v);

%% save files
fileNameLPF = strcat('lena',string(order),'_LPF.jpg');
imwrite(y,map,fileNameLPF);

fileNameHPF = strcat('lena',string(b),'_HPF.jpg');
imwrite(z,map,fileNameHPF);

%% graph

% LPF
f1 = figure;
xAxis= 1:1:256;
plot(xAxis,x(50,:),'k');
hold on;
plot(xAxis,y(50,:), 'r');

%HPF
f2 = figure;
xAxis= 1:1:256;
plot(xAxis,x(50,:),'k');
hold on;
plot(xAxis,z(50,:),'r');

%% fft

k = fft(y);
f3 = figure;
xAxis= 1:1:256;
plot(xAxis,x(50,:));
hold on;
plot(xAxis,k(50,:));