clc;
clear all;
close all;


message = randn([0,1],1,100000);  %전송하는 메시지
for x = 0:1:10
   epoch = 0; % trial 횟수 
   while(error = 200)
       symbol+noise; %수신 심벌
       
for i = 1:1:length(message)
    if messege[i] == 1
        bit = 1;
    else
        bit = 0;
        
        