clc
clear
a=rand(1,10000);
for i=1:length(a)
    if i==1
        avgNum1=a(1);
    else
        avgNum1=((i-1)/i)*avgNum1+(1/i)*a(i);
    end
    
end
avgNum2=mean(a(1:i));