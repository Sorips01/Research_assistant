message=randi([0,1],1,1000000);
count=0;
simbol=message;               %�ɺ�ȭ
for i = 1:1:length(message)
    if(message(1,i)==0)
        simbol(1,i)=-1;
    end
end

for x= 0:1:10
    epoch=0;
    error=0;
    while error==200
        S=sum(PSK.^2)/length(PSK);