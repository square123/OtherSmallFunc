function [ output ] = selRSSI(input)
%去掉前后百分之五的数，然后选取最大值
Temp=sort(input);
n=length(input);
deNum=ceil(n*0.05);
Temp(1:1+deNum)=-100;
Temp(n-deNum:n)=-100;
output=max(Temp);
end

