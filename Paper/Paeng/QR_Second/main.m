clear all;
close all;

Antenna = [
    8, 8;
    8, 16;
    16, 16;
    16, 32;
    32, 32;
    ];

for i=1:1:length(Antenna)
    ISDIC_Serial_QR_func(Antenna(i, 1),Antenna(i, 2));
    ISDIC_Serial_QR_func_LC(Antenna(i, 1),Antenna(i, 2));
end